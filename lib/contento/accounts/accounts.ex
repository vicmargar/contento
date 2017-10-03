defmodule Contento.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false

  alias Contento.Repo
  alias Contento.Accounts.User

  def get_user(id) when is_binary(id), do: get_user(id: id)
  def get_user(conds) when is_list(conds), do: Repo.get_by(User, conds)

  def list_users(pagination_params, conds \\ []) do
    User
    |> where(^conds)
    |> order_by(desc: :inserted_at)
    |> Repo.paginate(pagination_params)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def create_user_with_activation(attrs \\ %{}) do
    %User{}
    |> User.changeset_with_activation(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user), do: User.changeset(user, %{})

  def change_user_with_activation(%User{} = user), do: User.changeset_with_activation(user, %{})

  def password_correct?(%User{} = user, password), do: Comeonin.Argon2.checkpw(password, user.password_hash)

  def count_users do
    Repo.aggregate(from(u in User), :count, :id)
  end

  def activate_user(token) do
    if user = get_user(activation_token: token) do
      user
      |> User.changeset(%{})
      |> User.activate()
      |> Repo.update()
    else
      {:error, :user_does_not_exist}
    end
  end

  def user_active?(user) do
    user.joined_at && user.password_hash
  end

  def update_user_login_at(user) do
    update_user(user, %{
      last_login_at: Timex.now()
    })
  end
end
