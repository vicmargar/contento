defmodule ContentoWeb.SettingsController do
  use ContentoWeb, :controller

  alias Contento.Settings
  alias Contento.Settings.Setting

  def show(conn, _params) do
    if settings = Settings.get_settings() do
      changeset = Settings.change_settings(settings)
      render(conn, "show.html", settings: settings, changeset: changeset)
    end
  end

  def update(conn, %{"setting" => settings_params}) do
    if settings = Settings.get_settings() do
      with {:ok, %Setting{} = _settings} <- Settings.update_settings(settings, settings_params) do
        conn
        |> put_flash(:info, :updated)
        |> redirect(to: admin_settings_path(conn, :show))
      else
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "show.html", settings: settings, changeset: changeset)
      end
    end
  end

  def update_theme(conn, %{"setting" => settings_params}) do
    if settings = Settings.get_settings() do
      with {:ok, %Setting{} = _settings} <- Settings.update_settings(settings, settings_params) do
        conn
        |> put_flash(:info, :applied)
        |> redirect(to: admin_theme_path(conn, :show, settings.theme))
      end
    end
  end
end
