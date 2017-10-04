defmodule ContentoWeb.WebsiteView do
  use ContentoWeb, :theme_view

  def page_title(:index, %{settings: %{website_description: desc}}), do: desc
  def page_title(:page_or_post, %{page: page}), do: page.title
  def page_title(:page_or_post, %{post: post}), do: post.title
  def page_title(:page_or_post, _assigns), do: gettext("Not Found")
end
