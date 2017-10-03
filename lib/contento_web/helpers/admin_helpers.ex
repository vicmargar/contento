defmodule ContentoWeb.AdminHelpers do
  import Phoenix.Controller, only: [view_module: 1, action_name: 1]

  def page_title(%{assigns: assigns} = conn) do
    try do
      page_title = apply(view_module(conn), :page_title, [action_name(conn), assigns])

      "Contento - #{page_title}"
    rescue
      FunctionClauseError -> "Contento"
      UndefinedFunctionError -> "Contento"
    end
  end

  def active?(conn, path) do
    if path == Path.join(["/" | conn.path_info]), do: true, else: false
  end

  def active_class(conn, path) do
    if active?(conn, path), do: "active", else: ""
  end

  def timeago(datetime, fallback \\ nil) do
    if datetime do
      Timex.from_now(datetime)
    else
      fallback
    end
  end
end
