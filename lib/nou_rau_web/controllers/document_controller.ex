defmodule NouRauWeb.DocumentController do
  use NouRauWeb, :controller

  alias NouRau.Repo
  alias NouRau.Collections.Document
  import Ecto.Query

  def download(conn, %{"id" => id}) do
    document =
        Repo.one from d in Document,
        where: d.id == ^id,
        select: d,
        preload: [:attachment]

    unless document, do: send_resp(conn, :not_found, "")

    conn
    |> send_download({:file, "priv/static" <> document.attachment.file_path})
  end
end
