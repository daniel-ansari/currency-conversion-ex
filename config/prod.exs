import Config

config :currency_conversion_ex, :exchange_rate,
  api: CurrencyConversionEx.Api.Apilayer.ExchangeRate,
  url: "https://api.apilayer.com/exchangerates_data/latest",
  api_key: "lCUqaPED89QEEetr8p5azKgogrQ6uDTc"
# Do not print debug messages in production
config :logger, level: :info

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.
