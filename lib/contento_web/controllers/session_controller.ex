defmodule ContentoWeb.SessionController do
  use ContentoWeb, :controller

  alias Contento.Accounts
  alias Contento.Accounts.User
  alias Contento.Guardian

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    if user = Accounts.get_user(email: email) do
      if Accounts.user_active?(user) do
        if Accounts.password_correct?(user, password) do
          with {:ok, user} <- Accounts.update_user_login_at(user) do
            conn
            |> Guardian.Plug.sign_in(user)
            |> put_flash(:info, :session_created)
            |> redirect(to: admin_dashboard_path(conn, :index))
          end
        else
          conn
          |> put_flash(:error, :wrong_credentials)
          |> redirect(to: session_path(conn, :new))
        end
      else
        conn
        |> put_flash(:info, :requires_activation)
        |> redirect(to: session_path(conn, :new))
      end
    else
      conn
      |> put_flash(:error, :wrong_credentials)
      |> redirect(to: session_path(conn, :new))
    end
  end

  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: session_path(conn, :new))
  end

  def activate(conn, %{"token" => token}) do
    with {:ok, %User{} = user} = Accounts.activate_user(token) do
      with :ok <- send_welcome_email(user) do
        conn
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: admin_account_path(conn, :index))
      end
    end
  end

  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> put_flash(:error, :no_session)
    |> redirect(to: session_path(conn, :new))
  end

  defp send_welcome_email(user) do
    user
    |> Contento.Mailer.Email.welcome_email()
    |> Contento.Mailer.deliver_later()
    :ok
  end
end
