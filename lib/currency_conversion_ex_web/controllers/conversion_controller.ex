defmodule CurrencyConversionExWeb.ConversionController do
  @moduledoc """
  The ConversionController handles currency conversion requests.

  ## Actions

  ### `create/2`
  Converts currency based on provided parameters.

  #### Parameters
  - `from_currency`: Currency to convert from.
  - `to_currency`: Currency to convert to.
  - `value`: Amount to convert.

  #### Responses
  - **Success (200 OK)**:
    ```json
    {
      "data": {
        "converted_value": 600,
        "conversion_rate": 30
      }
    }
    ```

  - **Error (400 Bad Request)**:
    ```json
    {
      "message": "Invalid params provided"
    }
    ```

  - **Error (500 Internal Server Error)**:
    ```json
    {
      "message": "Internal server error"
    }
    ```

  ## Example
      iex> CurrencyConversionExWeb.ConversionController.create(conn, %{"from_currency" => "THB", "to_currency" => "USD", "value" => 20})
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
