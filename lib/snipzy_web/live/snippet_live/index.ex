defmodule SnipzyWeb.SnippetLive.Index do
  use SnipzyWeb, :live_view

  alias Snipzy.Snippets
  alias Snipzy.Snippets.Snippet
  alias Snipzy.Accounts

  @impl true
  def mount(_params, session, socket) do
    # TODO: you could only pass the user_token at this point
    user = Accounts.get_user_by_session_token(session["user_token"])
    {:ok,
     socket
     |> assign(:snippets, list_snippets(user.id))
     |> assign(:user, user)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Snippet")
    |> assign(:snippet, Snippets.get_snippet!(id))
  end

  defp apply_action(socket, :new, _params) do
    user = socket.assigns.user
    IO.inspect(user)

    socket
    |> assign(:page_title, "New Snippet")
    |> assign(:user, user)
    |> assign(:snippet, %Snippet{
      code: "Insert your snippet here",
      language: "elixir"
    })
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Your snippets")
    |> assign(:snippet, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    snippet = Snippets.get_snippet!(id)
    {:ok, _} = Snippets.delete_snippet(snippet)

    {:noreply, assign(socket, :snippets, list_snippets(socket.assigns.user.id))}
  end

  defp list_snippets(user_id) do
    Snippets.list_user_snippets(user_id)
  end
end
