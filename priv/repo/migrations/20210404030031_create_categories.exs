defmodule NouRau.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string, null: false
      add :description, :string, null: false

      timestamps()
    end

  end
end
