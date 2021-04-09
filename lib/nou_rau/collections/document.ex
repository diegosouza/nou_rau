defmodule NouRau.Collections.Document do
  use Ecto.Schema
  import Ecto.Changeset
  alias NouRau.Collections.{Attachment, Category}

  schema "documents" do
    field :description, :string
    field :name, :string

    belongs_to :category, Category
    has_one :attachment, Attachment

    timestamps()
  end

  @doc false
  def changeset(document, attrs) do
    document
    |> cast(attrs, [:name, :description, :category_id])
    |> validate_required([:name])
    |> cast_assoc(:category)
    |> cast_assoc(:attachment)
  end
end
