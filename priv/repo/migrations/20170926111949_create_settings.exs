defmodule Contento.Repo.Migrations.CreateSettings do
  use Ecto.Migration

  def change do
    create table(:settings) do
      add :website_title, :string
      add :website_description, :string

      add :maintenance, :boolean, default: false
      add :maintenance_message, :string

      timestamps()
    end
  end
end
