defmodule CurrencyConversionEx.ConversionTest do
  use ExUnit.Case

  alias CurrencyConversionEx.Conversion

  test "convert USD to THB" do
    amount = 100.0
    from_currency = "USD"
    to_currency = "THB"

    assert {:ok, converted_amount} = Conversion.convert(amount, from_currency, to_currency)
    assert converted_amount == 3200.00
  end
end
