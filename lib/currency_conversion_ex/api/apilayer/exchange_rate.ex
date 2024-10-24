defmodule CurrencyConversionEx.Api.Apilayer.ExchangeRate do
  @moduledoc """
  A module for fetching real-time exchange rates from the API Layer.

  ## Configuration
  The module uses settings from your application's environment. Make sure to configure the API key and URL in your `config.exs` file:

  ```elixir
  config :currency_conversion_ex, :exchange_rate,
    api: CurrencyConversionEx.Api.Apilayer.ExchangeRate,
    url: "https://api.apilayer.com/exchangerates_data/latest",
    api_key: "your_api_key_here"  # Replace with your actual API key
  ```

  Ensure that sensitive information such as the API key is kept secure and
  not exposed in version control.

  ## Functions

  ### `fetch_rates/0`

  Fetches the latest exchange rates from the configured API.

  ## Examples

      iex> CurrencyConversionEx.Api.Apilayer.ExchangeRate.fetch_rates()
      {:ok, %{"base" => "EUR", "date" => "2024-10-24", "rates" => %{"USD" => 1.0, "EUR" => 0.85, ...}}}

  This function returns a tuple `{:ok, rates}` on success, where `rates`
  is a map of the latest exchange rates.

  In case of an error, it returns a tuple `{:error, reason}` with the
  error information.
  """
  @config Application.compile_env(:currency_conversion_ex, :exchange_rate)
  @url @config[:url]
  @api_key @config[:api_key]

  @doc """
  Fetches the exchange rates from the configured API.

  ## Examples

      iex> CurrencyConversionEx.Api.Real.ExchangeRate.fetch_rates()
      {:ok, %{"USD" => 1.0, "EUR" => 0.85, ...}}

  This function constructs a request to the exchange rate API and returns
  the latest exchange rates.

  ## Returns

  - `{:ok, rates}`: A tuple containing `:ok` and a map of exchange rates
    if the request is successful.
  - `{:error, reason}`: A tuple containing `:error` and a reason
    for failure if the request is unsuccessful.
  """
  def fetch_rates do
    @url
    |> get_exchange_rates()
    |> handle_response()
  end

  defp get_exchange_rates(url) do
    HTTPoison.get(url, headers(), params: access_key_param())
  end

  defp handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    {:ok, Poison.decode!(body)}
  end

  defp handle_response({:ok, %HTTPoison.Response{status_code: status_code, body: body}}) do
    {:error, %{status_code: status_code, body: Poison.decode!(body)}}
  end

  defp handle_response({:error, response}) do
    {:error, %{status_code: response.status_code, body: Poison.decode!(response.body)}}
  end

  defp headers do
    [{"Content-Type", "application/json"}]
  end

  defp access_key_param do
    %{apikey: @api_key}
  end
end
