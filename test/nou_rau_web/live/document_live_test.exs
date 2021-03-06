defmodule NouRauWeb.DocumentLiveTest do
  use NouRauWeb.ConnCase

  import Phoenix.LiveViewTest

  alias NouRau.Collections

  @create_attrs %{description: "some description", title: "some title"}
  @update_attrs %{description: "some updated description", title: "some updated title"}
  @invalid_attrs %{description: nil, title: nil}

  defp fixture(:document) do
    {:ok, document} = Collections.create_document(@create_attrs)
    document
  end

  defp create_document(_) do
    document = fixture(:document)
    %{document: document}
  end

  describe "Index" do
    setup [:create_document]

    test "lists all documents", %{conn: conn, document: document} do
      {:ok, _index_live, html} = live(conn, Routes.document_index_path(conn, :index))

      assert html =~ "Listing Documents"
      assert html =~ document.description
    end

    test "saves new document", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.document_index_path(conn, :index))

      assert index_live |> element("a", "New Document") |> render_click() =~
               "New Document"

      assert_patch(index_live, Routes.document_index_path(conn, :new))

      assert index_live
             |> form("#document-form", document: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#document-form", document: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.document_index_path(conn, :index))

      assert html =~ "Document created successfully"
      assert html =~ "some description"
    end

    test "updates document in listing", %{conn: conn, document: document} do
      {:ok, index_live, _html} = live(conn, Routes.document_index_path(conn, :index))

      assert index_live |> element("#document-#{document.id} a", "Edit") |> render_click() =~
               "Edit Document"

      assert_patch(index_live, Routes.document_index_path(conn, :edit, document))

      assert index_live
             |> form("#document-form", document: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#document-form", document: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.document_index_path(conn, :index))

      assert html =~ "Document updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes document in listing", %{conn: conn, document: document} do
      {:ok, index_live, _html} = live(conn, Routes.document_index_path(conn, :index))

      assert index_live |> element("#document-#{document.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#document-#{document.id}")
    end
  end

  describe "Show" do
    setup [:create_document]

    test "displays document", %{conn: conn, document: document} do
      {:ok, _show_live, html} = live(conn, Routes.document_show_path(conn, :show, document))

      assert html =~ "Show Document"
      assert html =~ document.description
    end

    test "updates document within modal", %{conn: conn, document: document} do
      {:ok, show_live, _html} = live(conn, Routes.document_show_path(conn, :show, document))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Document"

      assert_patch(show_live, Routes.document_show_path(conn, :edit, document))

      assert show_live
             |> form("#document-form", document: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#document-form", document: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.document_show_path(conn, :show, document))

      assert html =~ "Document updated successfully"
      assert html =~ "some updated description"
    end
  end
end
