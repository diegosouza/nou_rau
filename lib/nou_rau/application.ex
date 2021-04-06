defmodule NouRau.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias NouRau.Collections.Upload

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      NouRau.Repo,
      # Start the Telemetry supervisor
      NouRauWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: NouRau.PubSub},
      # Start the Endpoint (http/https)
      NouRauWeb.Endpoint
      # Start a worker by calling: NouRau.Worker.start_link(arg)
      # {NouRau.Worker, arg}
    ]

    Upload.dir() |> File.mkdir!

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NouRau.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    NouRauWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
