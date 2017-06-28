defmodule Backend.Web.UserView do
  use Backend.Web, :view
  alias Backend.Web.UserView

  def render("index.json", %{accounts: accounts}) do
    %{data: render_many(accounts, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      firstname: user.firstname,
      lastname: user.lastname,
      email: user.email}
  end
end
