defmodule CurrencyConversionEx.Conversion do
  @moduledoc """
  The Conversion context.
  """

  @json_file_path Path.join(:code.priv_dir(:currency_conversion_ex), "mock/exchange_rate.json")

  def fetch_rates do
    case File.read(@json_file_path) do
      {:ok, content} ->
        case Poison.decode(content) do
          {:ok, %{"success" => true, "rates" => rates}} ->
            {:ok, rates}
          {:error, reason} ->
            {:error, "Failed to decode JSON: #{reason}"}
        end
      {:error, reason} ->
        {:error, "Failed to read file: #{reason}"}
    end
  end

  def convert(amount, from_currency, to_currency) do
    case fetch_rates() do
      {:ok, rates} ->
        case Map.get(rates, to_currency) do
          nil -> {:error, "Conversion rate not available for #{from_currency} to #{to_currency}"}
          rate ->
            converted_amount = amount * rate
            {:ok, converted_amount}
        end

      {:error, _reason} ->
        {:error, "Failed to fetch rates"}
    end
  end
end
