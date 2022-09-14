defmodule Memorilo.Post.Worker do
  @moduledoc """
  Schedule message and publish then at deadline
  """
  require Logger
  use GenServer, restart: :transient
  alias Memorilo.Post.Delivery
  alias Memorilo.Mail.Mailer
  alias Memorilo.TimeUtils

  def start_link(%Delivery{} = delivery) do
    GenServer.start_link(__MODULE__, delivery)
  end

  @impl true
  def init(%Delivery{} = delivery) do
    send(self(), :schedule)
    {:ok, delivery}
  end

  @impl true
  def handle_info(:schedule, %Delivery{delivery_time: delivery_time} = delivery) do
    wating_time_in_ms = TimeUtils.compute_waiting_time_in_ms(delivery_time)
    :timer.send_after(wating_time_in_ms, {:deliver, delivery})
    Logger.info("#{inspect(self())} scheduled a message to #{delivery_time}")
    {:noreply, delivery}
  end

  def handle_info(
        {:deliver, %Delivery{subject: subject, content: content, to: to} = delivery},
        _state
      ) do
    message = Mailer.build_message(subject, content, to)
    Mailer.send(message)
    Logger.info("#{inspect(self())} sends #{inspect(delivery)}")
    {:stop, :normal, :ok}
  end
end
