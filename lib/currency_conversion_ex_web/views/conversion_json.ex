defmodule CurrencyConversionExWeb.ConversionJSON do
  def render("conversion.json", %{conversion: conversion}) do
    %{data: render_conversion(conversion)}
  end

  def render_conversion(conversion) do
    %{
      converted_value: conversion.converted_value,
      conversion_rate: conversion.conversion_rate
    }
  end
end
