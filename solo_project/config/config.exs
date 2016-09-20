# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :solo_project,
  ecto_repos: [SoloProject.Repo]

# Configures the endpoint
config :solo_project, SoloProject.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Fdpq/9eZGHKU4F0F76GlSIKBpzTsfbejYE+2GmP0pww8h4uSgN40TZOAtzI9ybr6",
  render_errors: [view: SoloProject.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SoloProject.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
