defmodule ContentoWeb.AccountController do
  use ContentoWeb, :controller

  alias Contento.Accounts
  alias Contento.Accounts.User

  def index(conn, _params) do
    user = current_resource(conn)
    changeset = Accounts.change_user(user)

    render(conn, "index.html", user: user, changeset: changeset)
  end

  def update(conn, %{"user" => user_params}) do
    user = current_resource(conn)

    with {:ok, %User{} = _user} <- Accounts.update_user(user, user_params) do
      conn
      |> put_flash(:info, :updated)
      |> redirect(to: admin_account_path(conn, :index))
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", user: user, changeset: changeset)
    end
  end

  def update_password(conn, %{"user" => user_params}) do
    user = current_resource(conn)

    with {:ok, %User{} = _user} <- Accounts.update_user(user, user_params) do
      conn
      |> put_flash(:info, :updated_password)
      |> redirect(to: admin_account_path(conn, :index))
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", user: user, changeset: changeset)
    end
  end
end
