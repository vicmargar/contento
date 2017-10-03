defmodule Contento.Accounts.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Contento.Accounts.User
  alias Contento.Content.{Post, Page}

  @required_fields ~w(name email handle)a
  @optional_fields ~w(website bio location password password_hash activation_token joined_at last_login_at)a

  schema "users" do
    field :name, :string
    field :email, :string
    field :handle, :string

    field :website, :string
    field :bio, :string
    field :location, :string

    field :password, :any, virtual: true
    field :password_hash, :string

    field :activation_token, :string
    field :joined_at, :naive_datetime

    field :last_login_at, :naive_datetime

    has_many :posts, Post, foreign_key: :author_id
    has_many :pages, Page, foreign_key: :author_id

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
    |> unique_constraint(:handle)
    |> validate_format(:email, ~r/@/)
    #|> validate_format(:handle, ~r[a-Z0-9])
    |> validate_password()
    |> hash_password()
    |> activate()
  end

  @doc false
  def changeset_with_activation(%User{} = user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
    |> unique_constraint(:handle)
    |> validate_format(:email, ~r/@/)
    # |> validate_format(:handle, ~r[a-Z0-9])
    |> put_activation_info()
  end

  def hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Argon2.hashpwsalt(password))
      _ ->
        changeset
    end
  end

  def validate_password(changeset) do
    changeset
    |> validate_length(:password, min: 8, max: 32)
    |> validate_confirmation(:password, message: "password and confirmation does not match")
  end

  def put_activation_info(changeset) do
    put_change(changeset, :activation_token, UUID.uuid4(:hex))
  end

  def activate(changeset) do
    changeset
    |> put_change(:activation_token, nil)
    |> put_change(:joined_at, Timex.now())
  end
end
