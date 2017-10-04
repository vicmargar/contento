defmodule Mix.Tasks.Contento.Load.Themes do
  use Mix.Task

  require Logger

  import Mix.Ecto

  alias Contento.Themes

  @base_path "priv/themes"
  @config_filename "theme.json"

  def run(_args) do
    ensure_started(Contento.Repo, [])

    load_themes_into_database()
  end

  def load_themes_into_database do
    themes_available()
    |> Enum.each(fn theme_config ->
      if theme = Themes.get_theme(alias: theme_config["alias"]) do
        Logger.info("Updating \"#{theme.alias}\" theme if necessary...")
        Themes.update_theme(theme, theme_config)
      else
        Logger.info("Creating \"#{theme_config["alias"]}\" theme...")
        Themes.create_theme(theme_config)
      end
    end)
  end

  def themes_available do
    @base_path <> "/**/" <> @config_filename
    |> Path.wildcard()
    |> Enum.reduce([], fn(theme_file, acc) ->
      with {:ok, file_content} <- File.read(theme_file) do
        theme_config = file_content
        |> Poison.decode!()
        |> Map.merge(%{"alias" => theme_alias_from_path(theme_file)})

        acc ++ [theme_config]
      end
    end)
  end

  def theme_alias_from_path(path) do
    path
    |> String.replace(@base_path <> "/", "")
    |> String.replace("/" <> @config_filename, "")
  end
end
