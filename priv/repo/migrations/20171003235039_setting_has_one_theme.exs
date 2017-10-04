defmodule Contento.Repo.Migrations.SettingHasOneTheme do
  use Ecto.Migration

  def change do
    alter table(:settings) do
      add :theme_id, references(:themes)
    end

    alter table(:themes) do
      add :setting_id, references(:settings)
    end
  end
end
