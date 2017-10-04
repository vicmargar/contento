defmodule ContentoWeb.WebsiteController do
  use ContentoWeb, :controller

  alias Contento.Content

  def index(conn, _params) do
    posts = Content.list_posts(published: true)
    render(conn, "index.html", posts: posts)
  end

  def page_or_post(conn, %{"slug" => slug} = _params) do
    cond do
      page = Content.get_page(slug: slug) ->
        render(conn, "page.html", page: page)
      post = Content.get_post(slug: slug) ->
        render(conn, "post.html", post: post)
      true ->
        render(conn, "not_found.html")
    end
  end
end
