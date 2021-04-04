defmodule NouRau.CollectionsTest do
  use NouRau.DataCase

  alias NouRau.Collections

  describe "documents" do
    alias NouRau.Collections.Document

    @valid_attrs %{description: "some description", title: "some title"}
    @update_attrs %{description: "some updated description", title: "some updated title"}
    @invalid_attrs %{description: nil, title: nil}

    def document_fixture(attrs \\ %{}) do
      {:ok, document} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Collections.create_document()

      document
    end

    test "list_documents/0 returns all documents" do
      document = document_fixture()
      assert Collections.list_documents() == [document]
    end

    test "get_document!/1 returns the document with given id" do
      document = document_fixture()
      assert Collections.get_document!(document.id) == document
    end

    test "create_document/1 with valid data creates a document" do
      assert {:ok, %Document{} = document} = Collections.create_document(@valid_attrs)
      assert document.description == "some description"
      assert document.title == "some title"
    end

    test "create_document/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Collections.create_document(@invalid_attrs)
    end

    test "update_document/2 with valid data updates the document" do
      document = document_fixture()
      assert {:ok, %Document{} = document} = Collections.update_document(document, @update_attrs)
      assert document.description == "some updated description"
      assert document.title == "some updated title"
    end

    test "update_document/2 with invalid data returns error changeset" do
      document = document_fixture()
      assert {:error, %Ecto.Changeset{}} = Collections.update_document(document, @invalid_attrs)
      assert document == Collections.get_document!(document.id)
    end

    test "delete_document/1 deletes the document" do
      document = document_fixture()
      assert {:ok, %Document{}} = Collections.delete_document(document)
      assert_raise Ecto.NoResultsError, fn -> Collections.get_document!(document.id) end
    end

    test "change_document/1 returns a document changeset" do
      document = document_fixture()
      assert %Ecto.Changeset{} = Collections.change_document(document)
    end
  end
end
