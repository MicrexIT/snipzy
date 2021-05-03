defmodule Snipzy.Repo.Migrations.AddUpdateTsvectorTrigger do
  use Ecto.Migration

  def up do
    execute("""
    CREATE FUNCTION snippets_name_trigger() RETURNS trigger AS $$
    begin
      new.tsv :=
        to_tsvector('pg_catalog.english', coalesce(new.title, ' '));
      return new;
    end
    $$ LANGUAGE plpgsql;
    """)

    execute("""
    CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
    ON snippets FOR EACH ROW EXECUTE PROCEDURE snippets_name_trigger();
    """)
  end

  def down do
    execute("drop trigger tsvectorupdate on snippets;")
    execute("drop function snippets_name_trigger();")
  end
end
