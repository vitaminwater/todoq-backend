defmodule Backend.Web.AuthController do
  use Backend.Web, :controller

  action_fallback Backend.Web.FallbackController

  alias Backend.Accounts.User

  def login(conn, %{"auth" => %{"email" => email, "password" => password}}) do
    with {:ok, %User{} = user} <- Backend.Accounts.login(email, password) do
      new_conn = Guardian.Plug.api_sign_in(conn, user)
      jwt = Guardian.Plug.current_token(new_conn)
      {:ok, claims} = Guardian.Plug.claims(new_conn)
      exp = Map.get(claims, "exp")
      
      conn
        |> render("show.json", %{user: user, jwt: jwt, exp: exp})
    end
  end

end
