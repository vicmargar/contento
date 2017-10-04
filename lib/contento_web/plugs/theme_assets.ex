defmodule ContentoWeb.Plug.ThemeAssets do
  import Plug.Conn

  alias Plug.Static
  alias Contento.Themes

  def init(opts), do: opts

  def call(conn, _) do
    plug_opts = Static.init(at: "/", from: assets_path(conn), gzip: false)
    Static.call(conn, plug_opts)
  end

  defp assets_path(conn),
    do: Path.join(["priv/themes", conn.assigns[:settings].theme.alias, "assets"])
end
