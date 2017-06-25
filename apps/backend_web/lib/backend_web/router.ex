defmodule Backend.Web.Router do
  use Backend.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Backend.Web do
    pipe_through :api

    resources "/activities", ActivityController, except: [:new, :edit]
    resources "/logs", LogController, except: [:new, :edit]
  end
end
