defmodule Contento.Repo.Migrations.UserHasManyPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :author_id, references(:users)
    end
  end
end
