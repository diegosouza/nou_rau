defmodule NouRauWeb.CategoryLive.Index do
  use NouRauWeb, :live_view

  alias NouRau.Collections
  alias NouRau.Collections.Category

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, :categories, [])
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Category")
    |> assign(:categories, Collections.list_categories_for_another())
    |> assign(:category, Collections.get_category!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Category")
    |> assign(:category, %Category{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Categories")
    |> assign(:categories, Collections.list_categories_with_subcategories_count())
    |> assign(:category, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    category = Collections.get_category!(id)
    {:ok, _} = Collections.delete_category(category)

    {:noreply, assign(socket, :categories, list_categories())}
  end

  defp list_categories do
    Collections.list_categories()
  end
end
