defmodule NouRauWeb.DocumentLive.Show do
  use NouRauWeb, :live_view

  alias NouRau.Collections

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, categories: Collections.list_categories())
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:document, Collections.get_document!(id))}
  end

  defp page_title(:show), do: "Show Document"
  defp page_title(:edit), do: "Edit Document"
end
