defmodule CurrencyConversionExWeb.ConversionControllerTest do
  use CurrencyConversionExWeb.ConnCase

  @valid_params %{
    "from_currency" => "THB",
    "to_currency" => "USD",
    "value" => 5000
  }

  @invalid_params %{
    "from_currency" => "INVALID",
    "to_currency" => "USD",
    "value" => 5000
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates a currency conversion", %{conn: conn} do
    conn = post(conn, Routes.conversion_path(conn, :create), @valid_params)

    assert json_response(conn, 200)["data"]["converted_value"] == 147.815
    assert json_response(conn, 200)["data"]["conversion_rate"] == 0.029563
  end

  test "returns error when params are invalid", %{conn: conn} do
    conn = post(conn, Routes.conversion_path(conn, :create), @invalid_params)

    assert json_response(conn, 400)["error"]["message"] ==
             "Invalid currency type provided. Currency=INVALID"
  end
end
