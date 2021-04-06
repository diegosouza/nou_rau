defmodule NouRauWeb.DocumentLive.FormComponent do
  use NouRauWeb, :live_component

  alias NouRau.Collections
  alias NouRau.Collections.{Document,Upload}

  @impl true
  def update(%{document: document} = assigns, socket) do
    changeset = Collections.change_document(document)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> allow_upload(:file, accept: Upload.allowed_extensions())}
  end

  @impl true
  def handle_event("validate", %{"document" => document_params}, socket) do
    changeset =
      socket.assigns.document
      |> Collections.change_document(document_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"document" => document_params}, socket) do
    save_document(socket, socket.assigns.action, document_params)
  end

  defp save_document(socket, :edit, document_params) do
    document = put_document_file(socket, socket.assigns.document)

    case Collections.update_document(document, document_params, &consume_files(socket, &1)) do
      {:ok, _document} ->
        {:noreply,
         socket
         |> put_flash(:info, "Document updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_document(socket, :new, document_params) do
    document = put_document_file(socket, %Document{})

    case Collections.create_document_from(document, document_params, &consume_files(socket, &1)) do
      {:ok, _document} ->
        {:noreply,
         socket
         |> put_flash(:info, "Document created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp put_document_file(socket, %Document{} = document) do
    {[entry|_], []} = uploaded_entries(socket, :file)
    file_path = Routes.static_path(socket, "/uploads/" <> Upload.filename(entry))

    %Document{document | file: file_path}
  end

  defp consume_files(socket, %Document{} = document) do
    consume_uploaded_entries(socket, :file, &Upload.new_entry/2)
    {:ok, document}
  end
end
