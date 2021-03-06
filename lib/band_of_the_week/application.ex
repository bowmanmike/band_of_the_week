defmodule BandOfTheWeek.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      BandOfTheWeek.Repo,
      # Start the Telemetry supervisor
      BandOfTheWeekWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: BandOfTheWeek.PubSub},
      # Start the Endpoint (http/https)
      BandOfTheWeekWeb.Endpoint,
      {Finch, name: BandOfTheWeekFinch}
      # Start a worker by calling: BandOfTheWeek.Worker.start_link(arg)
      # {BandOfTheWeek.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BandOfTheWeek.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BandOfTheWeekWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
