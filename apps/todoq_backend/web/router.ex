defmodule TodoQ.Router do
  use TodoQ.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TodoQ do
    pipe_through :api
    resources "/activities", ActivityController, except: [:new, :edit] do
      resources "/logs", LogController, except: [:new, :edit]
    end
  end
end
