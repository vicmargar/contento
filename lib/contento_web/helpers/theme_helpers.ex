defmodule ContentoWeb.ThemeHelpers do
  import Phoenix.HTML, only: [raw: 1]
  import Phoenix.Controller, only: [view_module: 1, action_name: 1]

  def page_title(%{assigns: assigns} = conn, sep \\ "-") do
    website_title = assigns[:settings].website_title

    try do
      page_title = apply(view_module(conn), :page_title, [action_name(conn), assigns])

      "#{website_title} #{sep} #{page_title}"
    rescue
      FunctionClauseError -> "#{website_title}"
      UndefinedFunctionError -> "#{website_title}"
    end
  end

  def meta_data(%{assigns: assigns} = _conn) do
    website_description = assigns[:settings].website_description

    raw """
    <meta name="description" content="#{website_description}">
    """
  end

  def active?(conn, path) do
    if path == Path.join(["/" | conn.path_info]), do: true, else: false
  end

  def md_as_html(md) do
    raw Earmark.as_html!(md)
  end
end
