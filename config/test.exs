import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :band_of_the_week, BandOfTheWeek.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "band_of_the_week_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :band_of_the_week, BandOfTheWeekWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Kuq4fKlrOcY++CuPvGAK8RmGNep/9mOJ5aM8vCMBHl+d/4TM4kOHU7GqvOGN3+lP",
  server: false

# In test we don't send emails.
config :band_of_the_week, BandOfTheWeek.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
