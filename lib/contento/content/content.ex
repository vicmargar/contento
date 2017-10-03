defmodule Contento.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false

  alias Contento.Repo
  alias Contento.Content.{Page, Post}

  def get_page(id) when is_binary(id), do: get_page(id: id)
  def get_page(conds) when is_list(conds), do: get_page(Repo.get_by(Page, conds))
  def get_page(page) when is_map(page), do: Repo.preload(page, :author)
  def get_page(nil), do: nil

  def list_pages(pagination_params, conds \\ []) do
    Page
    |> where(^conds)
    |> order_by(desc: :inserted_at)
    |> preload(:author)
    |> Repo.paginate(pagination_params)
  end

  def create_page(attrs \\ %{}) do
    %Page{}
    |> Page.changeset(attrs)
    |> Repo.insert()
  end

  def update_page(%Page{} = page, attrs) do
    page
    |> Page.changeset(attrs)
    |> Repo.update()
  end

  def delete_page(%Page{} = page) do
    Repo.delete(page)
  end

  def change_page(%Page{} = page), do: Page.changeset(page, %{})

  def count_pages do
    Repo.aggregate(from(p in Page), :count, :id)
  end

  def get_post(id) when is_binary(id), do: get_post(id: id)
  def get_post(conds) when is_list(conds), do: get_post(Repo.get_by(Post, conds))
  def get_post(post) when is_map(post), do: Repo.preload(post, :author)
  def get_post(nil), do: nil

  def list_posts(pagination_params, conds \\ []) do
    Post
    |> where(^conds)
    |> order_by(desc: :inserted_at)
    |> preload(:author)
    |> Repo.paginate(pagination_params)
  end

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  def change_post(%Post{} = post), do: Post.changeset(post, %{})

  def count_posts do
    Repo.aggregate(from(p in Post), :count, :id)
  end
end
