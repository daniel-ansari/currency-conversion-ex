defmodule CurrencyConversionEx.Api.Mock.ExchangeRate do
  @moduledoc """
  A mock implementation of an API to fetch exchange rates.

  This module provides a function to read exchange rates from a JSON file located in the
  application's `priv` directory. It uses the Poison library to decode the JSON data
  into a usable Elixir format.
  """
  @json_file_path Path.join(:code.priv_dir(:currency_conversion_ex), "mock/exchange_rate.json")

  def fetch_rates do
    {:ok,
     @json_file_path
     |> File.read!()
     |> Poison.decode!()}
  end
end
