import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :currency_conversion_ex, CurrencyConversionExWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "kRTxpsaBXhaA/YFQ48DymYFlu6kjpewIb1Jp5RjBha3bLJF65xhdMF3R+LBbr+uf",
  server: false

config :currency_conversion_ex, :exchange_rate, api: CurrencyConversionEx.Api.Mock.ExchangeRate
# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
