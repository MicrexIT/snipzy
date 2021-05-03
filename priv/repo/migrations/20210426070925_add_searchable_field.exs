defmodule Snipzy.Repo.Migrations.AddSearchableField do
  use Ecto.Migration

  def change do
    alter table(:snippets) do
      add(:tsv, :tsvector)
    end

    create index(:snippets, [:tsv], name: :snippets_title_name_vector, using: "GIN")
    # create index(:snippets, [:tsv], name: :something_something_name_vector, using: "GIN")
  end
end
