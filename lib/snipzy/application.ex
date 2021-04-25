defmodule Snipzy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Snipzy.Repo,
      # Start the Telemetry supervisor
      SnipzyWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Snipzy.PubSub},
      # Start the Endpoint (http/https)
      SnipzyWeb.Endpoint
      # Start a worker by calling: Snipzy.Worker.start_link(arg)
      # {Snipzy.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Snipzy.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SnipzyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
