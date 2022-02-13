defmodule DeimosSurface.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      # DeimosSurface.Repo,
      # Start the Telemetry supervisor
      DeimosSurfaceWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: DeimosSurface.PubSub},
      # Start the Endpoint (http/https)
      DeimosSurfaceWeb.Endpoint
      # Start a worker by calling: DeimosSurface.Worker.start_link(arg)
      # {DeimosSurface.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DeimosSurface.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DeimosSurfaceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
