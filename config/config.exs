import Config

config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase

config :memorilo, :default_time_zone, "America/Sao_Paulo"

config :memorilo, Memorilo.Mail.Mailer,
  adapter: Swoosh.Adapters.Gmail,
  access_token: ""

import_config "#{config_env()}.exs"
