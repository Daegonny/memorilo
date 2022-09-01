defmodule Memorilo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Memorilo.Post.Supervisor, []},
      # Start the Telemetry supervisor
      MemoriloWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Memorilo.PubSub},
      # Start the Endpoint (http/https)
      MemoriloWeb.Endpoint
      # Start a worker by calling: Memorilo.Worker.start_link(arg)
      # {Memorilo.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Memorilo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MemoriloWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
