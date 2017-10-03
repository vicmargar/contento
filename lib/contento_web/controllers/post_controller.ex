defmodule ContentoWeb.PostController do
  use ContentoWeb, :controller

  alias Contento.Content
  alias Contento.Content.Post

  def index(conn, params) do
    data = Content.list_posts(params)

    render(conn, "index.html", posts: data.entries, page_number: data.page_number,
                               page_size: data.page_size, total_pages: data.total_pages,
                               total_entries: data.total_entries)
  end

  def new(conn, _params) do
    changeset = Content.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    post_params = put_author(post_params, current_resource(conn))

    with {:ok, %Post{} = _post} <- Content.create_post(post_params) do
      conn
      |> put_flash(:info, :created)
      |> redirect(to: admin_post_path(conn, :index))
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    if post = Content.get_post(id) do
      changeset = Content.change_post(post)
      render(conn, "show.html", post: post, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    if post = Content.get_post(id) do
      with {:ok, %Post{} = post} <- Content.update_post(post, post_params) do
        conn
        |> put_flash(:info, :updated)
        |> redirect(to: admin_post_path(conn, :show, post))
      else
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "show.html", post: post, changeset: changeset)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    if post = Content.get_post(id) do
      with {:ok, _post} = Content.delete_post(post) do
        conn
        |> put_flash(:info, :deleted)
        |> redirect(to: admin_post_path(conn, :index))
      end
    end
  end

  defp put_author(params, user) do
    Map.merge(params, %{"author_id" => user.id})
  end
end
