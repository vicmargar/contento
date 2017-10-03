defmodule Contento.Settings.Setting do
  use Ecto.Schema

  import Ecto.Changeset

  alias Contento.Settings.Setting

  @required_fields ~w(website_title website_description)a
  @optional_fields ~w(maintenance maintenance_message)a

  schema "settings" do
    field :website_title, :string
    field :website_description, :string

    field :maintenance, :boolean, default: false
    field :maintenance_message, :string

    timestamps()
  end

  @doc false
  def changeset(%Setting{} = setting, attrs) do
    setting
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
