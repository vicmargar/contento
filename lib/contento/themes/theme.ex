defmodule Contento.Themes.Theme do
  use Ecto.Schema

  import Ecto.Changeset

  alias Contento.Themes.Theme

  @required_fields ~w(alias)a
  @optional_fields ~w()a

  schema "themes" do
    field :alias, :string

    has_one :setting, Contento.Settings.Setting

    timestamps()
  end

  @doc false
  def changeset(%Theme{} = theme, attrs) do
    theme
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:alias)
  end
end
