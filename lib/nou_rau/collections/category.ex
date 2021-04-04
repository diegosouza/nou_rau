defmodule NouRau.Collections.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias NouRau.Collections.Document

  schema "categories" do
    field :description, :string
    field :name, :string

    has_many :documents, Document

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
  end
end
