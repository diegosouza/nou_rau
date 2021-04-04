defmodule NouRau.Collections.Document do
  use Ecto.Schema
  import Ecto.Changeset

  schema "documents" do
    field :description, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(document, attrs) do
    document
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
