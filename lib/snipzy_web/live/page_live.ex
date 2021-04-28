defmodule SnipzyWeb.PageLive do
  use SnipzyWeb, :live_view

  alias SnipzyWeb.Components.SnippetEditor

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", results: %{})}
  end

  # @impl true
  # def handle_event("show", _, socket) do
  #   IO.inspect('here')
  #   SnippetEditor.show("editor")
  #   {:noreply, socket}
  # end
end
