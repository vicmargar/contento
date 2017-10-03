defmodule ContentoWeb.SessionView do
  use ContentoWeb, :view

  def page_title(:new, _), do: gettext("Login")
end
