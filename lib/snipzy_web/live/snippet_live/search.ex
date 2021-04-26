defmodule SnipzyWeb.SnippetLive.Search do
  use SnipzyWeb, :live_view
  alias Snipzy.Snippets
  alias Snipzy.Accounts

  @impl true
  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])

    {:ok,
     socket
     |> assign(:user, user)
     |> assign(:search, "")
     |> assign(:snippets, search_snippets("", user))}
  end

  @impl true
  def handle_event("search", %{"value" => ""}, socket) do
    {:noreply, assign(socket, :snippets, [])}
  end

  @impl true
  def handle_event("search", %{"value" => value}, socket) do
    user = socket.assigns.user
    snippets = search_snippets(value, user)
    IO.inspect(snippets)
    {:noreply, assign(socket, :snippets, snippets)}
  end

  defp search_snippets(search, user) do
    Snippets.search_user_snippets(search, user)
  end
end
