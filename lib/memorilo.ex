defmodule Memorilo do
  @moduledoc """
  Memorilo keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias Memorilo.Post.Supervisor
  alias Memorilo.Post.Delivery

  def schedule_message(%Delivery{} = delivery) do
    Supervisor.schedule(delivery)
  end
end
