defmodule CurrencyConversionEx.Conversion do
  @exchange_rates %{
    "USD" => %{"THB" => 32.0, "EUR" => 0.85, "GBP" => 0.76},
    "EUR" => %{"USD" => 1.18, "THB" => 37.65},
    "GBP" => %{"USD" => 1.32, "THB" => 43.80},
    "THB" => %{"USD" => 0.031, "EUR" => 0.027, "GBP" => 0.023}
  }

  def convert(amount, from_currency, to_currency) do
  case Map.get(@exchange_rates, from_currency) do
      rates ->
        case Map.get(rates, to_currency) do
          nil -> {:error, "Conversion rate not available for #{from_currency} to #{to_currency}"}
          rate -> {:ok, amount * rate}
        end
    end
  end
end
