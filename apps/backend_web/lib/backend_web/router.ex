defmodule Backend.Web.Router do
  use Backend.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_auth do  
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug Guardian.Plug.EnsureAuthenticated, handler: Backend.Web.AuthController
  end  

  scope "/", Backend.Web do
    pipe_through :api

    resources "/users", UserController, only: [:create]

    post "/login", AuthController, :login
  end

  scope "/", Backend.Web do
    pipe_through [:api, :api_auth]

    resources "/users", UserController, except: [:new, :edit, :create]

    resources "/activities", ActivityController, except: [:new, :edit] do
      resources "/logs", LogController, only: [:index, :create]
    end
    resources "/logs", LogController, only: [:show, :update, :delete]
  end
end
