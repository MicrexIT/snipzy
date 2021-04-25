defmodule Snipzy.Repo.Migrations.CreateSnippets do
  use Ecto.Migration

  def change do
    create table(:snippets) do
      add :code, :text
      add :description, :text
      add :title, :string
      add :language, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:snippets, [:user_id])
  end
end
