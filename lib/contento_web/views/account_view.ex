defmodule ContentoWeb.AccountView do
  use ContentoWeb, :view

  def page_title(:new, _), do: gettext("Account")
end
