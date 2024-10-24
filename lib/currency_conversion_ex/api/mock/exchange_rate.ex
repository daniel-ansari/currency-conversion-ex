defmodule CurrencyConversionEx.Api.Mock.ExchangeRate do
  @moduledoc """
  A mock implementation of an API to fetch exchange rates.

  This module provides a function to read exchange rates from a JSON file located in the
  application's `priv` directory. It uses the Poison library to decode the JSON data
  into a usable Elixir format.
  """
  @json_file_path Path.join(:code.priv_dir(:currency_conversion_ex), "mock/exchange_rate.json")

  @doc """
  Fetches the exchange rates from the mock JSON file.

  ## Examples

      iex> CurrencyConversionEx.Api.Mock.ExchangeRate.fetch_rates()
      {:ok, %{"success": true, "timestamp": 1729699808, "base": "THB", "date": "2024-10-23",
      "rates": {"USD" => 0.029563, ...}}

  This function reads the content of the `exchange_rate.json` file and decodes it
  into a map of exchange rates.

  ## Returns

  - `{:ok, rates}`: A tuple containing `:ok` and a map of exchange rates if the file is read
    and decoded successfully.
  - An error tuple if the file cannot be read or decoded.
  """
  def fetch_rates do
    {:ok,
     @json_file_path
     |> File.read!()
     |> Poison.decode!()}
  end
end
