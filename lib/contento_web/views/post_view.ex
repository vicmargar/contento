defmodule ContentoWeb.PostView do
  use ContentoWeb, :view

  def page_title(:index, _), do: gettext("Posts")
  def page_title(:new, _), do: gettext("New Post")
  def page_title(:show, %{post: post}), do: post.title
end
