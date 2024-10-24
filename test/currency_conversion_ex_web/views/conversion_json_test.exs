defmodule CurrencyConversionExWeb.ConversionJSONTest do
  use ExUnit.Case, async: true

  alias CurrencyConversionExWeb.ConversionJSON

  @conversion_data %{
    converted_value: 147.815,
    conversion_rate: 0.029563
  }

  test "render/2 creates proper JSON structure for conversion" do
    json = ConversionJSON.render("conversion.json", %{conversion: @conversion_data})

    expected_json = %{
      data: %{
        converted_value: 147.815,
        conversion_rate: 0.029563
      }
    }

    assert json == expected_json
  end

  test "render_conversion/1 creates proper JSON for conversion details" do
    conversion_json = ConversionJSON.render_conversion(@conversion_data)

    expected_conversion_json = %{
      converted_value: 147.815,
      conversion_rate: 0.029563
    }

    assert conversion_json == expected_conversion_json
  end
end
