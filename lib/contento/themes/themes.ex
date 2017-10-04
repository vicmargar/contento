defmodule Contento.Themes do
  @moduledoc """
  The Themes context.
  """

  require Logger

  import Ecto.Query, warn: false

  alias Contento.Repo
  alias Contento.Themes.Theme

  def get_theme(id) when is_binary(id), do: get_theme(id: id)
  def get_theme(conds) when is_list(conds), do: Repo.get_by(Theme, conds)

  def list_themes(pagination_params, conds \\ []) do
    Theme
    |> where(^conds)
    |> order_by(desc: :inserted_at)
    |> Repo.paginate(pagination_params)
  end

  def create_theme(attrs \\ %{}) do
    %Theme{}
    |> Theme.changeset(attrs)
    |> Repo.insert()
  end

  def update_theme(%Theme{} = theme, attrs) do
    theme
    |> Theme.changeset(attrs)
    |> Repo.update()
  end

  def delete_theme(%Theme{} = theme) do
    Repo.delete(theme)
  end

  def change_theme(%Theme{} = theme), do: Theme.changeset(theme, %{})

  def count_themes do
    Repo.aggregate(from(p in Theme), :count, :id)
  end

  # def load_themes_into_database do
  #   Logger.info("Loading themes into database...")
  #
  #   themes_available()
  #   |> Enum.each(fn theme_config ->
  #     if theme = get_theme(alias: theme_config["alias"]) do
  #       update_theme(theme, theme_config)
  #     else
  #       create_theme(theme_config)
  #     end
  #   end)
  # end

  # def themes_available do
  #   "priv/themes/**/package.json"
  #   |> Path.wildcard()
  #   |> Enum.reduce([], fn(theme_file, acc) ->
  #     with {:ok, file_content} <- File.read(theme_file) do
  #       theme_config = file_content
  #       |> Poison.decode!()
  #       |> Map.merge(%{"alias" => theme_alias_from_path(theme_file)})
  #
  #       acc ++ [theme_config]
  #     end
  #   end)
  # end

  # def theme_alias_from_path(path) do
  #   path
  #   |> String.replace("priv/themes/", "")
  #   |> String.replace("/package.json", "")
  # end
end
