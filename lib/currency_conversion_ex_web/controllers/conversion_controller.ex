defmodule CurrencyConversionExWeb.ConversionController do
  @moduledoc """
  The ConversionController handles currency conversion requests.
  """
  use CurrencyConversionExWeb, :controller

  alias CurrencyConversionEx.Conversion
  alias CurrencyConversionExWeb.{ConversionJSON, ErrorJSON}

  def create(conn, params) do
    case Conversion.convert_currency(params) do
      {:ok, %{body: body}} ->
        conn
        |> put_view(ConversionJSON)
        |> render("conversion.json", conversion: body)

      {:error, %{body: error_message, status_code: status_code}} ->
        conn
        |> put_status(status_code)
        |> put_view(ErrorJSON)
        |> render("#{status_code}.json", %{message: error_message})
    end
  end
end
