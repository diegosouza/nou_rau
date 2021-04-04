defmodule NouRau.Repo.Migrations.CreateDocuments do
  use Ecto.Migration

  def change do
    create table(:documents) do
      add :name, :string, null: false
      add :description, :string, null: true

      timestamps()
    end

  end
end
