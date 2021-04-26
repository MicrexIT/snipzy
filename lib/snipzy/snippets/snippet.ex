defmodule Snipzy.Snippets.Snippet do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias __MODULE__

  schema "snippets" do
    field :code, :string
    field :description, :string
    field :language, :string
    field :title, :string
    belongs_to :user, Snipzy.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(snippet, attrs) do
    snippet
    |> cast(attrs, [:code, :description, :title, :language])
    |> validate_required([:code, :description, :title, :language])
  end

  def query_users_snippets(user_id) do
    from s in Snippet, where: s.user_id == ^user_id
  end
end
