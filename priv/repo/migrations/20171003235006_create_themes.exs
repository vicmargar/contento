defmodule Contento.Repo.Migrations.CreateThemes do
  use Ecto.Migration

  def change do
    create table(:themes) do
      add :alias, :string

      timestamps()
    end
  end
end
