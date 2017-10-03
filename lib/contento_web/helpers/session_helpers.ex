defmodule ContentoWeb.SessionHelpers do
  def current_user(conn), do: Contento.Guardian.Plug.current_resource(conn)
end
