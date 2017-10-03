defmodule ContentoWeb.Plug.CheckUser do
  use Guardian.Plug.Pipeline, otp_app: :contento

  import Plug.Conn, only: [halt: 1]
  import Phoenix.Controller, only: [redirect: 2]
  import Contento.Guardian.Plug, only: [current_resource: 1, sign_out: 1]

  def call(conn, _opts) do
    if is_nil(current_resource(conn)) do
      conn
      |> sign_out()
      |> redirect(to: "/login")
      |> halt()
    else
      conn
    end
  end
end
