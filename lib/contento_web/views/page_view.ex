defmodule ContentoWeb.PageView do
  use ContentoWeb, :view

  def page_title(:index, _), do: gettext("Pages")
  def page_title(:new, _), do: gettext("New Page")
  def page_title(:show, %{page: page}), do: page.title
end
