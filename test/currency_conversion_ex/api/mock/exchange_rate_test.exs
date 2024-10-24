defmodule CurrencyConversionEx.Api.Mock.ExchangeRateTest do
  use ExUnit.Case, async: true
  alias CurrencyConversionEx.Api.Mock.ExchangeRate

  describe "fetch_rates/0" do
    test "returns decoded JSON when file is read successfully" do
      assert {:ok, response} = ExchangeRate.fetch_rates()
      assert response["success"] == true
      assert Map.has_key?(response, "rates")
      assert response["base"] == "THB"
    end
  end
end
