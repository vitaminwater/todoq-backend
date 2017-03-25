defmodule TodoQFrontend.Repo do
  use Ecto.Repo, otp_app: :todoq_frontend
end

defmodule TodoQFrontend.BroadcastRepo do
	alias TodoQFrontend.Repo
	alias TodoQFrontend.{Activity, Log}
	alias TodoQFrontend.ActivityChannel
	alias TodoQFrontend.LogChannel

	def insert(queryable, opts \\ []) do
		handle_repo_return Repo.insert(queryable, opts), :insert
	end

	def insert!(queryable, opts \\ []) do
		model = Repo.insert!(queryable, opts)
		model_event(model, :insert)
		model
	end

	def update(queryable, opts \\ []) do
		handle_repo_return Repo.update(queryable, opts), :update
	end

	def update!(queryable, opts \\ []) do
		model = Repo.update!(queryable, opts)
		model_event(model, :update)
		model
	end

	def delete(queryable, opts \\ []) do
		handle_repo_return Repo.delete(queryable, opts), :delete
	end

	def delete!(queryable, opts \\ []) do
		model = Repo.delete!(queryable, opts)
		model_event(model, :delete)
		model
	end

	defp handle_repo_return(return, type) do
		case return do
			{:ok, model} = good ->
				model_event(model, type)
				good
			otherwise -> otherwise
		end
	end

	defp model_event(%Activity{} = model, :insert) do
		ActivityChannel.insert_activity(model)
	end
	defp model_event(%Activity{} = model, :update) do
		ActivityChannel.update_activity(model)
	end
	defp model_event(%Activity{} = model, :delete) do
		ActivityChannel.delete_activity(model)
	end

	defp model_event(%Log{} = model, :insert) do
		LogChannel.insert_log(model)
	end
	defp model_event(%Log{} = model, :update) do
		LogChannel.update_log(model)
	end
	defp model_event(%Log{} = model, :delete) do
		LogChannel.delete_log(model)
	end

	defp model_event(_model, :update), do: :nothing
	defp model_event(_model, :insert), do: :nothing
end
