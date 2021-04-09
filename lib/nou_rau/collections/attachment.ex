defmodule NouRau.Collections.Attachment do
  use Ecto.Schema
  import Ecto.Changeset
  alias NouRau.Collections.Document

  schema "attachments" do
    field :file_path, :string
    field :original_filename, :string

    belongs_to :document, Document

    timestamps()
  end

  @doc false
  def changeset(attachment, attrs) do
    attachment
    |> cast(attrs, [:original_filename, :file_path])
    |> validate_required([:original_filename, :file_path])
  end
end
