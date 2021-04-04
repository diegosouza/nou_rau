defmodule NouRau.Repo.Migrations.CreateDocuments do
  use Ecto.Migration

  def change do
    create table(:documents) do
      add :title, :string, null: false
      add :description, :string, null: false

      timestamps()
    end

  end
end
