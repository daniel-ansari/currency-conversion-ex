defmodule CurrencyConversionEx.Conversion do
  @moduledoc """
  The Conversion context.
  """
  @exchange_api Application.compile_env(:currency_conversion_ex, :exchange_rate)[:api]
  @required_fields ["from_currency", "to_currency", "value"]

  def convert_currency(
        %{
          "from_currency" => from_currency,
          "to_currency" => to_currency,
          "value" => value
        } = _params
      ) do
    with {:ok, response} <- @exchange_api.fetch_rates(),
         {:ok, base_currency_exchange_rates} <-
           get_base_currency_exchange_rate(response["rates"], from_currency, to_currency),
         {:ok, converted_value} <-
           convert_values(base_currency_exchange_rates, value),
         {:ok, conversion_rate} <- get_conversion_rate(value, converted_value),
         {:ok, response} <- handle_response(conversion_rate, converted_value) do
      {:ok, response}
    else
      {:error, response} ->
        {:error, response}

      _ ->
        {:error, %{status_code: 500, body: "Internal server error"}}
    end
  end

  def convert_currency(params) do
    {:error,
     %{
       status_code: 400,
       body: "Invalid params provided, missing params=#{inspect(missing_params(params))}"
     }}
  end

  defp get_base_currency_exchange_rate(rates, from_currency, to_currency) do
    with {true, _} <- valid_currency?(rates, from_currency),
         {true, _} <- valid_currency?(rates, to_currency) do
      {:ok, {rates[from_currency], rates[to_currency]}}
    else
      {false, currency} ->
        {:error,
         %{
           status_code: 400,
           body: "Invalid currency type provided. Currency=#{currency}"
         }}
    end
  end

  defp valid_currency?(rates, currency),
    do: {is_integer(rates[currency]) or is_float(rates[currency]), currency}

  defp convert_values({from_rate, to_rate}, value),
    do: {:ok, value / from_rate * to_rate}

  defp get_conversion_rate(value, converted_value), do: {:ok, converted_value / value}

  defp missing_params(params), do: Enum.reject(@required_fields, fn field -> params[field] end)

  defp handle_response(conversion_rate, converted_value) do
    response = %{
      status_code: 200,
      body: %{
        conversion_rate: conversion_rate,
        converted_value: converted_value
      }
    }

    {:ok, response}
  end
end
