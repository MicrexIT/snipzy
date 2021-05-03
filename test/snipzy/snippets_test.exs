defmodule Snipzy.SnippetsTest do
  use Snipzy.DataCase

  alias Snipzy.Snippets
  alias Snipzy.AccountsFixtures

  describe "snippets" do
    alias Snipzy.Snippets.Snippet

    @valid_attrs %{
      code: "some code",
      description: "some description",
      language: "some language",
      title: "some title"
    }
    @update_attrs %{
      code: "some updated code",
      description: "some updated description",
      language: "some updated language",
      title: "some updated title"
    }

    @create_user_attrs %{
      email: "rand@gmaild.com",
      password: "asdfasdfasdf"
    }

    @invalid_attrs %{code: nil, description: nil, language: nil, title: nil}

    def snippet_fixture(attrs \\ %{}) do
      user = AccountsFixtures.user_fixture(@create_user_attrs)
      attrs = attrs |> Enum.into(@valid_attrs)
      {:ok, snippet} = Snippets.create_snippet(user, attrs)

      %{snippet: snippet, user: user}
    end

    test "list_snippets/0 returns all snippets" do
      %{snippet: snippet} = snippet_fixture()
      assert Snippets.list_snippets() == [snippet]
    end

    test "get_snippet!/1 returns the snippet with given id" do
      %{snippet: snippet} = snippet_fixture()
      assert Snippets.get_snippet!(snippet.id) == snippet
    end

    test "create_snippet/1 with valid data creates a snippet" do
      user = AccountsFixtures.user_fixture(@create_user_attrs)
      assert {:ok, %Snippet{} = snippet} = Snippets.create_snippet(user, @valid_attrs)
      assert snippet.code == "some code"
      assert snippet.description == "some description"
      assert snippet.language == "some language"
      assert snippet.title == "some title"
    end

    test "create_snippet/1 with invalid data returns error changeset" do
      user = AccountsFixtures.user_fixture(@create_user_attrs)
      assert {:error, %Ecto.Changeset{}} = Snippets.create_snippet(user, @invalid_attrs)
    end

    test "update_snippet/2 with valid data updates the snippet" do
      %{snippet: snippet} = snippet_fixture()
      assert {:ok, %Snippet{} = snippet} = Snippets.update_snippet(snippet, @update_attrs)
      assert snippet.code == "some updated code"
      assert snippet.description == "some updated description"
      assert snippet.language == "some updated language"
      assert snippet.title == "some updated title"
    end

    test "update_snippet/2 with invalid data returns error changeset" do
      %{snippet: snippet} = snippet_fixture()
      assert {:error, %Ecto.Changeset{}} = Snippets.update_snippet(snippet, @invalid_attrs)
      assert snippet == Snippets.get_snippet!(snippet.id)
    end

    test "delete_snippet/1 deletes the snippet" do
      %{snippet: snippet} = snippet_fixture()
      assert {:ok, %Snippet{}} = Snippets.delete_snippet(snippet)
      assert_raise Ecto.NoResultsError, fn -> Snippets.get_snippet!(snippet.id) end
    end

    test "change_snippet/1 returns a snippet changeset" do
      %{snippet: snippet} = snippet_fixture()
      assert %Ecto.Changeset{} = Snippets.change_snippet(snippet)
    end
  end
end
