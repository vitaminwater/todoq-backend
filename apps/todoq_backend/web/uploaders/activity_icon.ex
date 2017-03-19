defmodule TodoQ.ActivityIcon do
  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:original, :thumb]

  def __storage, do: Arc.Storage.Local

  def validate({file, _}) do
    ~w(.jpg .jpeg .gif .png) |> Enum.member?(Path.extname(file.file_name))
  end

  def filename(version, _) do
    version
  end

  # Define a thumbnail transformation:
  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail 250x250^ -gravity center -extent 250x250 -format png", :png}
  end

  # Override the storage directory:
  def storage_dir(_, {_, activity}) do
    "uploads/activity/icon/#{activity.randomPath}"
  end

end
