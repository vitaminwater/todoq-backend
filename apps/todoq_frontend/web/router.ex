defmodule TodoQFrontend.Router do
  use TodoQFrontend.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TodoQFrontend do
    pipe_through :api
    resources "/activities", ActivityController, except: [:new, :edit] do
      resources "/logs", LogController, only: [:create, :index]
    end
    resources "/logs", LogController, except: [:new, :edit, :index, :create]
  end
end
