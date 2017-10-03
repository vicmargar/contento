defmodule Contento.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :handle, :string

      add :website, :string
      add :bio, :string
      add :location, :string

      add :password_hash, :string

      add :activation_token, :string
      add :joined_at, :naive_datetime

      add :last_login_at, :naive_datetime

      timestamps()
    end
  end
end
