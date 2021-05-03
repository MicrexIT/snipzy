defmodule SnipzyWeb.SnippetLiveTest do
  use SnipzyWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Snipzy.Snippets
  alias Snipzy.Snippets.Snippet
  alias Snipzy.AccountsFixtures

  @create_attrs %{
    code: "some code",
    description: "some description",
    language: "some language",
    title: "some title"
  }

  @create_user_attrs %{
    email: "rand@gmaild.com",
    password: "asdfasdfasdf"
  }

  @update_attrs %{
    code: "some updated code",
    description: "some updated description",
    language: "some updated language",
    title: "some updated title"
  }
  @invalid_attrs %{code: nil, description: nil, language: nil, title: nil}

  defp fixture(:snippet, user) do
    {:ok, snippet} = Snippets.create_snippet(user, @create_attrs)
    # {:ok, snippet} = Snippets.create_snippet()
    snippet
  end

  defp create_snippet(_) do
    user = AccountsFixtures.user_fixture(@create_user_attrs)
    snippet = fixture(:snippet, user)
    %{snippet: snippet, user: user}
  end

  describe "Index" do
    setup [:create_snippet]

    test "lists all snippets", %{conn: conn, snippet: snippet, user: user} do
      conn = log_in_user(conn, user)
      {:ok, _index_live, html} = live(conn, Routes.snippet_index_path(conn, :index))

      assert html =~ "Snippets"
      assert html =~ snippet.title
    end

    test "saves new snippet", %{conn: conn, user: user} do
      conn = log_in_user(conn, user)
      {:ok, index_live, _html} = live(conn, Routes.snippet_index_path(conn, :index))

      assert index_live |> element("a", "New Snippet") |> render_click() =~
               "New Snippet"

      assert_patch(index_live, Routes.snippet_index_path(conn, :new))

      # TODO: the current form does not show this error with an invalid snippet
      # assert index_live
      #        |> form("#snippet-form", snippet: @invalid_attrs)
      #        |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#snippet-form", snippet: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.snippet_index_path(conn, :index))

      assert html =~ "Snippet created successfully"
      assert html =~ "Description"
    end

    test "updates snippet in listing", %{conn: conn, snippet: snippet, user: user} do
      conn = log_in_user(conn, user)
      {:ok, index_live, _html} = live(conn, Routes.snippet_index_path(conn, :index))

      assert index_live |> element("#snippet-#{snippet.id} a", "Edit") |> render_click() =~
               "Edit Snippet"

      assert_patch(index_live, Routes.snippet_index_path(conn, :edit, snippet))

      # same as above
      # assert index_live
      #        |> form("#snippet-form", snippet: @invalid_attrs)
      #        |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#snippet-form", snippet: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.snippet_index_path(conn, :index))

      assert html =~ "Snippet updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes snippet in listing", %{conn: conn, snippet: snippet, user: user} do
      conn = log_in_user(conn, user)
      {:ok, index_live, _html} = live(conn, Routes.snippet_index_path(conn, :index))

      assert index_live |> element("#snippet-#{snippet.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#snippet-#{snippet.id}")
    end
  end

  describe "Show" do
    setup [:create_snippet]

    test "displays snippet", %{conn: conn, snippet: snippet, user: user} do
      conn = log_in_user(conn, user)
      {:ok, _show_live, html} = live(conn, Routes.snippet_show_path(conn, :show, snippet))

      assert html =~ "Show Snippet"
      assert html =~ snippet.title
    end

    test "updates snippet within modal", %{conn: conn, snippet: snippet, user: user} do
      conn = log_in_user(conn, user)
      {:ok, show_live, _html} = live(conn, Routes.snippet_show_path(conn, :show, snippet))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Snippet"

      assert_patch(show_live, Routes.snippet_show_path(conn, :edit, snippet))

      # same as above
      # assert show_live
      #        |> form("#snippet-form", snippet: @invalid_attrs)
      #        |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#snippet-form", snippet: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.snippet_show_path(conn, :show, snippet))

      assert html =~ "Snippet updated successfully"
      assert html =~ "some updated title"
    end
  end
end
