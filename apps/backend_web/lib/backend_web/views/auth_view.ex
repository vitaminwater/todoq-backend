defmodule Backend.Web.AuthView do
  use Backend.Web, :view
  alias Backend.Web.UserView

  def render("show.json", %{user: user, jwt: jwt, exp: exp}) do
    %{data:
      %{
        user: UserView.render("user.json", %{user: user}),
        jwt: jwt,
        exp: exp
      }
    }
  end

end
