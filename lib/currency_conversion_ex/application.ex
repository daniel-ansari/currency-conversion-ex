defmodule CurrencyConversionEx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CurrencyConversionExWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:currency_conversion_ex, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CurrencyConversionEx.PubSub},
      # Start a worker by calling: CurrencyConversionEx.Worker.start_link(arg)
      # {CurrencyConversionEx.Worker, arg},
      # Start to serve requests, typically the last entry
      CurrencyConversionExWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CurrencyConversionEx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CurrencyConversionExWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
