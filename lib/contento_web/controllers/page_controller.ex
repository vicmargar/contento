defmodule ContentoWeb.PageController do
  use ContentoWeb, :controller

  alias Contento.Content
  alias Contento.Content.Page

  def index(conn, params) do
    data = Content.list_pages(params)

    render(conn, "index.html", pages: data.entries, page_number: data.page_number,
                               page_size: data.page_size, total_pages: data.total_pages,
                               total_entries: data.total_entries)
  end

  def new(conn, _params) do
    changeset = Content.change_page(%Page{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"page" => page_params}) do
    page_params = put_author(page_params, current_resource(conn))

    with {:ok, %Page{} = _page} <- Content.create_page(page_params) do
      conn
      |> put_flash(:info, :created)
      |> redirect(to: admin_page_path(conn, :index))
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    if page = Content.get_page(id) do
      changeset = Content.change_page(page)
      render(conn, "show.html", page: page, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "page" => page_params}) do
    if page = Content.get_page(id) do
      with {:ok, %Page{} = page} <- Content.update_page(page, page_params) do
        conn
        |> put_flash(:info, :updated)
        |> redirect(to: admin_page_path(conn, :show, page))
      else
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "show.html", page: page, changeset: changeset)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    if page = Content.get_page(id) do
      with {:ok, _page} = Content.delete_page(page) do
        conn
        |> put_flash(:info, :deleted)
        |> redirect(to: admin_page_path(conn, :index))
      end
    end
  end

  defp put_author(params, user) do
    Map.merge(params, %{"author_id" => user.id})
  end
end
