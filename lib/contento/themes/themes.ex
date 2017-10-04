defmodule Contento.Themes do
  @moduledoc """
  The Themes context.
  """

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
end
