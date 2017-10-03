defmodule Contento.Content.Page do
  use Ecto.Schema

  import Ecto.Changeset

  alias Contento.Content.Page

  @required_fields ~w(slug author_id)a
  @optional_fields ~w(title content published published_at)a

  schema "pages" do
    field :slug, :string

    field :title, :string
    field :content, :string

    field :published, :boolean, default: false
    field :published_at, :naive_datetime

    belongs_to :author, Contento.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Page{} = page, attrs) do
    page
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:slug)
    |> put_published_at()
  end

  def put_published_at(changeset) do
    case get_change(changeset, :published) do
      true ->
        put_change(changeset, :published_at, Timex.now())
      false ->
        put_change(changeset, :published_at, nil)
      nil ->
        changeset
    end
  end
end
