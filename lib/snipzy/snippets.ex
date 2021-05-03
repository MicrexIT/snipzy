defmodule Snipzy.Snippets do
  @moduledoc """
  The Snippets context.
  """

  import Ecto.Query, warn: false
  alias Snipzy.Repo

  alias Snipzy.Snippets.{Snippet, Search}

  @doc """
  Returns the list of snippets.

  ## Examples

      iex> list_snippets()
      [%Snippet{}, ...]

  """
  def list_snippets do
    Repo.all(Snippet)
  end

  @doc """
  Returns the list of a user's snippets.

  ## Examples

      iex> list_snippets(1)
      [%Snippet{}, ...]

  """
  def list_user_snippets(user_id) do
    user_id
    |> Snippet.query_users_snippets()
    |> Repo.all()
  end

  def search_user_snippets(sentence, user) do
    sentence
    |> Search.get_user_query(user)
    |> IO.inspect()
    |> Repo.all()
  end

  @doc """
  Gets a single snippet.

  Raises `Ecto.NoResultsError` if the Snippet does not exist.

  ## Examples

      iex> get_snippet!(123)
      %Snippet{}

      iex> get_snippet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_snippet!(id), do: Repo.get!(Snippet, id)

  @doc """
  Creates a snippet.

  ## Examples

      iex> create_snippet(%User{}, %{field: value})
      {:ok, %Snippet{}}

      iex> create_snippet(%User{}, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_snippet(user, attrs \\ %{}) do
    # %Snippet{} |> Snippet.changeset(attrs) |> Repo.insert()

    user
    |> Ecto.build_assoc(:snippets, %{})
    |> Snippet.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a snippet.

  ## Examples

      iex> update_snippet(snippet, %{field: new_value})
      {:ok, %Snippet{}}

      iex> update_snippet(snippet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_snippet(%Snippet{} = snippet, attrs) do
    snippet
    |> Snippet.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a snippet.

  ## Examples

      iex> delete_snippet(snippet)
      {:ok, %Snippet{}}

      iex> delete_snippet(snippet)
      {:error, %Ecto.Changeset{}}

  """
  def delete_snippet(%Snippet{} = snippet) do
    Repo.delete(snippet)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking snippet changes.

  ## Examples

      iex> change_snippet(snippet)
      %Ecto.Changeset{data: %Snippet{}}

  """
  def change_snippet(%Snippet{} = snippet, attrs \\ %{}) do
    Snippet.changeset(snippet, attrs)
  end
end
