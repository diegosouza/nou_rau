defmodule NouRau.Collections.Upload do

  @default_dir "priv/static/uploads"

  def filename(entry), do: "#{entry.uuid}.#{ext(entry)}"

  def new_entry(meta, entry) do
    filename = filename(entry)
    dest = Path.join(dir(), filename)
    File.cp!(meta.path, dest)
  end

  def dir do
    Application.get_env(:nou_rau, :uploads_dir, @default_dir)
  end

  defp ext(uploaded) do
    MIME.extensions(uploaded.client_type) |> hd()
  end

  def allowed_extensions, do: [".pdf"]
end
