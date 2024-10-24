# CurrencyConversionEx

## Table of Contents

- [Introduction](#introduction)
  - [Used Technologies](#used-technologies)
    * [Phoenix](#phoenix)
    * [Coveralls](#coveralls)
- [Development Setup](#development-setup)
  * [Setup With Local Environment](#setup-with-local-environment)
- [Available Endpoints](#available-endpoints)
  * [Currency Conversion API](#currency-conversion-api)

## **Introduction**

CurrencyConversionEx is a simple and efficient currency exchange API built with Elixir and Phoenix. It allows users to convert between two currencies using exchange rates from an external API.

## **Used Technologies**

### **Phoenix**
[Phoenix](https://www.phoenixframework.org) is a modern and scalable framework for building APIs and web applications quickly.

### **Coveralls**
[Coveralls](https://coveralls.io/) hosts test coverage reports for this project, used in conjunction with [ExCoveralls](https://github.com/parroty/excoveralls).

## **Development Setup**

### **Setup With Local Environment**

⚠️ This doc will not cover the entire configuration process.

**Step 1** - Install Elixir, Erlang, and Phoenix.

Required Versions:
- Elixir 1.15.2
- Erlang 27
- Phoenix 1.7.14

Check the official [Elixir](https://elixir-lang.org/install.html) or [Phoenix](https://hexdocs.pm/phoenix/installation.html) docs for the installation process.

**Step 2** - Clone this repository;

**Step 3** - Run `mix deps.get` inside this repository;

**Step 4** - Run `mix phx.server` to start the server.

Now the application is up and running on `localhost:4000`.

It's possible to open an `IEx console` for this application by running `iex -S mix` or run tests by executing `mix test` or run tests with coveralls `mix coveralls`.

## **Available Endpoints**

This API offers three endpoints, one for converting values between two currencies and two others for listing all requests or user-specific ones.

To make requests to the API, it is recommended to use Postman, Curl, or similar tools.

### **Currency Conversion API**

To convert a value between two currencies, you can make a `POST` request to `localhost:4000/api/conversion` when in development mode. This request needs a JSON body with valid currency types as follows:

```json
{
  "from_currency": "USD",
  "to_currency": "THB",
  "value": 33.72
}
```
And valid parameter types:

```elixir
"from_currency" # String
"to_currency"   # String
"value"        # Integer (e.g., 10), Float (e.g., 10.5), or a valid String representation of a number (e.g., "10.5")
```

If all parameters are correctly specified, it should return a response like this:

```json
{
  "data": {
    "conversion_rate": 6.5,
    "converted_value": 65
  }
}
```