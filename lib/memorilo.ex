defmodule Memorilo do
  @moduledoc """
  Memorilo keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias Memorilo.Post.Supervisor
  alias Memorilo.Post.Delivery
  @one_minute 1 * 60

  def schedule_message(subject, content, to) do
    with {:ok, now} <- DateTime.now(default_time_zone()),
      delivery_time <- DateTime.add(now, @one_minute, :second),
      delivery <- Delivery.new(subject, content, to, delivery_time) do
      Supervisor.schedule(delivery)
    end
  end

  defp default_time_zone do
    Application.get_env(:memorilo, :default_time_zone)
  end
end
