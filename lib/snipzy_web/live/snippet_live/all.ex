defmodule SnipzyWeb.SnippetLive.All do
  use SnipzyWeb, :live_view
  alias Snipzy.Snippets

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:snippets, list_snippets())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "All Snippets")
    |> assign(:snippet, nil)
  end

  defp list_snippets() do
    Snippets.list_snippets()
  end
end
