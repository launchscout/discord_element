import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :discord_element, DiscordElement.Repo,
  username: "postgres",
  password: "postgres",
  database: "discord_element_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :discord_element, DiscordElementWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "LXIkDlob0Lu9gALYpwi2nvw1upyFBF88lmk1ZLGtX3rRZveZL/T5jSdAL/snR4o+",
  server: false

# In test we don't send emails.
config :discord_element, DiscordElement.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
