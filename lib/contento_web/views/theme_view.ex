defmodule ContentoWeb.ThemeView do
  use ContentoWeb, :view

  def page_title(:index, _), do: gettext("Themes")
  def page_title(:show, %{theme: theme}), do: theme.alias
end
