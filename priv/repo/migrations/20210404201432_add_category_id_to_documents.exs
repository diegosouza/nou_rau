defmodule NouRau.Repo.Migrations.AddCategoryIdToDocuments do
  use Ecto.Migration

  def change do
    alter table(:documents) do
      add :category_id, references(:categories), default: 1
    end
  end
end
