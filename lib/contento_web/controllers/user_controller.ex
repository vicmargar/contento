defmodule ContentoWeb.UserController do
  use ContentoWeb, :controller

  alias Contento.Accounts
  alias Contento.Accounts.User

  def index(conn, params) do
    data = Accounts.list_users(params)

    render(conn, "index.html", users: data.entries, page_number: data.page_number,
                               page_size: data.page_size, total_pages: data.total_pages,
                               total_entries: data.total_entries)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user_with_activation(user_params) do
      activation_link = session_url(conn, :activate, user.activation_token)

      with :ok <- send_activation_email(user, activation_link) do
        conn
        |> put_flash(:info, :created)
        |> redirect(to: admin_user_path(conn, :index))
      end
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    if user = Accounts.get_user(id) do
      changeset = Accounts.change_user(user)
      render(conn, "show.html", user: user, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    if user = Accounts.get_user(id) do
      with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
        conn
        |> put_flash(:info, :updated)
        |> redirect(to: admin_user_path(conn, :show, user))
      else
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "show.html", user: user, changeset: changeset)
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    if user = Accounts.get_user(id) do
      with {:ok, _user} = Accounts.delete_user(user) do
        conn
        |> put_flash(:info, :deleted)
        |> redirect(to: admin_user_path(conn, :index))
      end
    end
  end

  defp send_activation_email(user, activation_link) do
    user
    |> Contento.Mailer.Email.activation_email(activation_link)
    |> Contento.Mailer.deliver_later()
    :ok
  end
end
