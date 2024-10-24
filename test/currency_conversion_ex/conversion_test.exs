defmodule CurrencyConversionEx.ConversionTest do
  use ExUnit.Case

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
  end
end
