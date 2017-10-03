defmodule ContentoWeb.Plug.PasswordSetup do
  use Guardian.Plug.Pipeline, otp_app: :contento

  import Plug.Conn, only: [halt: 1]
  import Phoenix.Controller, only: [redirect: 2, put_flash: 3]
  import Guardian.Plug, only: [current_resource: 1]

  def call(conn, _opts) do
    if user = current_resource(conn) do
      if user.password_hash == nil do
        conn = put_flash(conn, :info, :setup_password)

        if should_redirect?(conn) do
          conn
          |> redirect(to: "/c/account")
          |> halt()
        else
          conn
        end
      else
        conn
      end
    else
      conn
    end
  end

  defp should_redirect?(conn) do
    "/c/account" != conn.request_path && "/c/account/password" != conn.request_path
  end
end
