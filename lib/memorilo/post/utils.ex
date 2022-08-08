defmodule Memorilo.Post.Utils do
  @moduledoc """
  Contains util functions for worker
  """

  def compute_waiting_time_in_ms(date_time),
    do: compute_waiting_time_in_ms(date_time, default_time_zone())

  def compute_waiting_time_in_ms(date_time, time_zone) do
    with {:ok, %{date: date, time: time}} <- extract_date_and_time(date_time),
    {:ok, deadline} <- DateTime.new(date, time, time_zone),
    {:ok, now} <- DateTime.now(time_zone) do
      DateTime.diff(deadline, now, :millisecond)
    end
  end

  defp extract_date_and_time(naive_date_time) do
    date = NaiveDateTime.to_date(naive_date_time)
    time = NaiveDateTime.to_time(naive_date_time)
    {:ok, %{date: date, time: time}}
  end

  defp default_time_zone do
    Application.get_env(:memorilo, :default_time_zone)
  end
end
