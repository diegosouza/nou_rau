defmodule NouRau.Repo.Migrations.AddFileToDocuments do
  use Ecto.Migration

  def change do
    alter table(:documents) do
      add :file, :string
    end
  end
end
