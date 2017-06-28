defmodule Backend.Web.Router do
  use Backend.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Backend.Web do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]

    resources "/activities", ActivityController, except: [:new, :edit] do
      resources "/logs", LogController, only: [:index, :create]
    end
    resources "/logs", LogController, only: [:show, :update, :delete]
  end
end
