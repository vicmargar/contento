defmodule Contento.Repo.Migrations.CreatePages do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :slug, :string

      add :title, :string
      add :content, :string

      add :published, :boolean, default: false
      add :published_at, :naive_datetime

      timestamps()
    end
  end
end
