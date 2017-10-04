defmodule ContentoWeb.WebsiteController do
  use ContentoWeb, :controller

  alias Contento.Content

  def index(conn, _params) do
    posts = Content.list_posts(published: true)
    do_render(conn, "index.html", posts: posts)
  end

  def page_or_post(conn, %{"slug" => slug} = _params) do
    cond do
      page = Content.get_page(slug: slug) ->
        do_render(conn, "page.html", page: page)
      post = Content.get_post(slug: slug) ->
        do_render(conn, "post.html", post: post)
      true ->
        do_render(conn, "not_found.html")
    end
  end

  defp do_render(conn, template, assigns \\ []) do
    theme_alias = conn.assigns[:settings].theme.alias
    layout_template = theme_alias <> "/templates/layout.html"
    action_template = theme_alias <> "/templates/" <> template

    conn
    |> put_layout({ContentoWeb.WebsiteView, layout_template})
    |> render(action_template, assigns)
  end
end
