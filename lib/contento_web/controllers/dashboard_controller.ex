defmodule ContentoWeb.DashboardController do
  use ContentoWeb, :controller

  alias Contento.Accounts
  alias Contento.Content

  def index(conn, _params) do
    counters = [
      posts: Content.count_posts(),
      pages: Content.count_pages(),
      users: Accounts.count_users()
    ]

    render(conn, "index.html", counters: counters)
  end
end
