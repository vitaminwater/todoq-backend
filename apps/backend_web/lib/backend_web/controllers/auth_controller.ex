defmodule Backend.Web.AuthController do
  use Backend.Web, :controller

  action_fallback Backend.Web.FallbackController

  alias Backend.Accounts.User

  def login(conn, %{"auth" => auth_params}) do
    with {:ok, %User{} = user} <- Backend.Accounts.login(auth_params["email"], auth_params["password"]) do
      conn
        |> render("show.json", user: user)
    end
  end

end
