defmodule Backend.Activities.ActivityIcon do
  use Arc.Definition
  use Arc.Ecto.Definition

  @acl :public_read
  @version [:original, :thumb]

  def validate({file, _}) do
    ~w(.jpg .jpeg .gif .png) |> Enum.member?(Path.extname(file.file_name))
  end

  def filename(version, {_, activity}) do
    "#{activity.randomPath}_#{version}"
  end

  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail 250x250^ -gravity center -extent 250x250 -format png", :png}
  end

  def s3_object_headers(version, {file, _}) do
    [content_type: Plug.MIME.path(file.file_name)]
  end
end
