defmodule ContentoWeb.Theme do
  @theme Application.get_env(:contento, :theme)

  def theme_dir do
    Path.join("priv/themes", theme_string())
  end

  def templates_dir do
    Path.join(theme_dir(), "templates")
  end

  def assets_dir do
    Path.join(theme_dir(), "assets")
  end

  defp theme_string do
    Atom.to_string(@theme)
  end
end
