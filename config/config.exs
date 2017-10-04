# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :contento,
  ecto_repos: [Contento.Repo]

# Configures the endpoint
config :contento, ContentoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Po8l2nty71omSetjdOA2LNrxAUOZ6ckTk9zQJruSNbxgGgT4ND1PT/yrsTteq7ao",
  render_errors: [view: ContentoWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Contento.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure Guardian pipelines
config :contento, ContentoWeb.Plug.AuthRequired,
  module: Contento.Guardian,
  error_handler: ContentoWeb.SessionController

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
