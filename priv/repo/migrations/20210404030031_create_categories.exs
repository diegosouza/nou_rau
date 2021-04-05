defmodule NouRau.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string, null: false
      add :description, :string, null: true

      timestamps()
    end

    now = NaiveDateTime.utc_now() |> NaiveDateTime.to_string()

    execute "INSERT INTO categories (name, description, inserted_at, updated_at) VALUES ('Uncategorized', 'Groups uncategorized documents', '#{now}', '#{now}')"

  end
end
