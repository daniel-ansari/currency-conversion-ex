defmodule CurrencyConversionEx.ConversionTest do
  use ExUnit.Case, async: true

  alias CurrencyConversionEx.Conversion

  describe "convert_currency/1" do
    test "successfully converts currency" do
      params = %{
        "from_currency" => "THB",
        "to_currency" => "USD",
        "value" => 5000
      }

      assert {:ok, response} = Conversion.convert_currency(params)
      assert response[:status_code] == 200
      assert response[:body][:converted_value] == 147.815
      assert response[:body][:conversion_rate] == 0.029563
    end

    test "returns error for invalid params" do
      params = %{"from_currency" => "THB", "to_currency" => "USD"}

      assert {:error, response} = Conversion.convert_currency(params)
      assert response[:status_code] == 400
      assert response[:body] == "Invalid params provided, missing params=[\"value\"]"
    end

    test "returns error for invalid currency" do
      params = %{
        "from_currency" => "INVALID",
        "to_currency" => "USD",
        "value" => 20
      }

      assert {:error, response} = Conversion.convert_currency(params)
      assert response[:status_code] == 400
      assert response[:body] == "Invalid currency type provided. Currency=INVALID"
    end
  end
end
