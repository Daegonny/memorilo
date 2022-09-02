defmodule Memorilo.Post.Worker do
  @moduledoc """
  Schedule message and publish then at deadline
  """
  use GenServer, restart: :transient
  alias Memorilo.Post.{Utils, Message, Delivery}
  alias Memorilo.Mail.Mailer

  def start_link(%Delivery{} = delivery) do
    GenServer.start_link(__MODULE__, delivery)
  end

  @impl true
  def init(%Delivery{} = delivery) do
    send(self(), :schedule)
    {:ok, delivery}
  end

  @impl true
  def handle_info(:schedule, %Delivery{message: message, delivery_time: delivery_time} = delivery) do
    wating_time_in_ms = Utils.compute_waiting_time_in_ms(delivery_time)
    :timer.send_after(wating_time_in_ms, {:deliver, message})
    IO.puts("#{inspect(self())} scheduled a message to #{delivery_time}")
    {:noreply, delivery}
  end

  def handle_info({:deliver, %Message{to: to, content: content} = message}, _state) do
    mail_message = Mailer.build_message(to, "Memori", content)
    Mailer.send(mail_message)
    IO.puts("#{inspect(self())} sends #{inspect(message)}")
    {:stop, :normal, :ok}
  end
end
