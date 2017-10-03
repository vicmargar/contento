defmodule ContentoWeb.DashboardView do
  use ContentoWeb, :view

  def page_title(:index, _), do: gettext("Dashboard")
end
