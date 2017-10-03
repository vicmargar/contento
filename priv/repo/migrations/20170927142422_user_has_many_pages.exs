defmodule Contento.Repo.Migrations.UserHasManyPages do
  use Ecto.Migration

  def change do
    alter table(:pages) do
      add :author_id, references(:users)
    end
  end
end
