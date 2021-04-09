defmodule NouRau.Repo.Migrations.CreateAttachments do
  use Ecto.Migration

  def change do
    create table(:attachments) do
      add :original_filename, :string
      add :file_path, :string
      add :document_id, references(:documents, on_delete: :nothing)

      timestamps()
    end

    create index(:attachments, [:document_id])
  end
end
