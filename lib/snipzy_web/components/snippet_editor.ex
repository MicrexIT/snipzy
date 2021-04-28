defmodule SnipzyWeb.Components.SnippetEditor do
  use Phoenix.LiveComponent

  def mount(socket) do
    {:ok, assign(socket, show: false)}
  end

  def render(assigns) do
    ~L"""
    <div id='editor' phx-update="ignore" phx-hook="editor">
      <div>
        <div id="ace-editor"></div>
    </div>
      </div>
    """
  end

  # Public API

  def show(editor_id) do
    send_update(__MODULE__, id: editor_id, show: true)
  end

  # Event handlers

  def handle_event("show", _, socket) do
    {:noreply, assign(socket, show: true)}
  end

  def handle_event("save", _, socket) do
    {:noreply, assign(socket, show: false)}
  end

  def handle_event("cancel", _, socket) do
    {:noreply, assign(socket, show: false)}
  end
end
