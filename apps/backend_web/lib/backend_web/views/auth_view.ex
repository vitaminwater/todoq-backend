defmodule Backend.Web.AuthView do
  use Backend.Web, :view
  alias Backend.Web.UserView

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

end
