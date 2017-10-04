defmodule ContentoWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use ContentoWeb, :controller
      use ContentoWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: ContentoWeb
      import Plug.Conn
      import ContentoWeb.Router.Helpers
      import ContentoWeb.Gettext
      import Contento.Guardian.Plug, only: [current_resource: 1]
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/contento_web/templates",
                        namespace: ContentoWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import ContentoWeb.Router.Helpers
      import ContentoWeb.ErrorHelpers
      import ContentoWeb.Gettext
      import ContentoWeb.AdminHelpers
      import ContentoWeb.FormHelpers
      import ContentoWeb.SessionHelpers
    end
  end

  def theme_view do
    quote do
      use Phoenix.View, root: "priv/themes", path: "",
                        pattern: "**/templates/**/*", namespace: ContentoWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import ContentoWeb.Router.Helpers
      import ContentoWeb.ErrorHelpers
      import ContentoWeb.Gettext
      import ContentoWeb.ThemeHelpers
      import ContentoWeb.SessionHelpers
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import ContentoWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
