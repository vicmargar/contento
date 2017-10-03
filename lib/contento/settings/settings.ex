defmodule Contento.Settings do
  @moduledoc """
  The Settings context.
  """

  import Ecto.Query, warn: false

  alias Contento.Repo
  alias Contento.Settings.Setting

  def get_settings() do
    if settings = Repo.all(Setting, limit: 1) do
      Enum.at(settings, 0)
    end
  end

  def create_settings(attrs \\ %{}) do
    %Setting{}
    |> Setting.changeset(attrs)
    |> Repo.insert()
  end

  def update_settings(%Setting{} = setting, attrs) do
    setting
    |> Setting.changeset(attrs)
    |> Repo.update()
  end

  def delete_settings(%Setting{} = setting) do
    Repo.delete(setting)
  end

  def change_settings(%Setting{} = setting), do: Setting.changeset(setting, %{})
end
