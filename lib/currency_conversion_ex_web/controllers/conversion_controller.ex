defmodule CurrencyConversionExWeb.ConversionController do
  use CurrencyConversionExWeb, :controller

  alias CurrencyConversionEx.Conversion

  def create(conn, %{"amount" => amount_str, "from_currency" => from_currency, "to_currency" => to_currency}) do
    case Float.parse(amount_str) do
      {amount, _} ->
        case Conversion.convert(amount, from_currency, to_currency) do
          {:ok, converted_amount} ->
            formatted_amount = :erlang.float_to_binary(converted_amount, [decimals: 2]) # Format to 2 decimal places
            json(conn, %{
              converted_amount: formatted_amount
            })

          {:error, message} ->
            json(conn, %{error: message})
        end

      :error ->
        json(conn, %{error: "Invalid amount format"})
    end
  end
end
