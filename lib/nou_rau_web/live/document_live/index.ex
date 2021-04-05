defmodule NouRauWeb.DocumentLive.Index do
  use NouRauWeb, :live_view

  alias NouRau.Collections
  alias NouRau.Collections.Document

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(
      socket,
      documents: Collections.list_documents(),
      categories: Collections.list_categories()
    )
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Document")
    |> assign(:document, Collections.get_document!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Document")
    |> assign(:document, %Document{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Documents")
    |> assign(:document, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    document = Collections.get_document!(id)
    {:ok, _} = Collections.delete_document(document)

    {:noreply, assign(socket, :documents, list_documents())}
  end

  defp list_documents do
    Collections.list_documents()
  end
end
