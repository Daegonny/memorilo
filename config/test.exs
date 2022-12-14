import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :memorilo, MemoriloWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "H9a02pOpIu46+4kZlHH8XXzv8A3Ha1VHQBNjAAoVPIfgdK8FlzjUjXlp5s+VXmbo",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
