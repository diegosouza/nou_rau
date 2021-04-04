defmodule NouRau.Repo.Migrations.AddCategoryIdToDocuments do
  use Ecto.Migration

  def change do
    alter table(:documents) do
      add :category_id, references(:categories)
    end
  end
end
