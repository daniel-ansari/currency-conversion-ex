defmodule CurrencyConversionEx.Api.Apilayer.ExchangeRate do
  @moduledoc """
  A module for fetching exchange rates from a real-time API Layer.
  """

  @config Application.compile_env(:currency_conversion_ex, :exchange_rate)
  @url @config[:url]
  @api_key @config[:api_key]

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
