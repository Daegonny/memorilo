defmodule Memorilo.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Memorilo.Post.Supervisor, []}
    ]

    opts = [strategy: :one_for_one, name: Memorilo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
