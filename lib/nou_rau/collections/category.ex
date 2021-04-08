defmodule NouRau.Collections.Category do
  use Ecto.Schema
  use Arbor.Tree,
    foreign_key: :parent_id,
    foreign_key_type: :integer

  alias NouRau.Collections.Document
  import Ecto.Changeset

  schema "categories" do
    field :description, :string
    field :name, :string
    field :subcategories_count, :integer, default: 0, virtual: :true

    belongs_to :parent, __MODULE__
    has_many :documents, Document

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name, :description, :parent_id])
    |> validate_required([:name])
  end
end
