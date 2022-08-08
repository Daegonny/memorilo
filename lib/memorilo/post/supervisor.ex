defmodule Memorilo.Post.Supervisor do
  @moduledoc """
  Dynamic superviser responsible for creating workers
  that schedule messages
  """
  use DynamicSupervisor
  alias Memorilo.Post.Worker
  alias Memorilo.Post.Shipping

  def schedule(%Shipping{} = shipping) do
    DynamicSupervisor.start_child(__MODULE__, {Worker, shipping})
  end

  def start_link(state) do
    DynamicSupervisor.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(_state) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
