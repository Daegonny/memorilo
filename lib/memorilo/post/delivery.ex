defmodule Memorilo.Post.Delivery do
  @moduledoc """
  Defines a Delivery struct with message and delivery_time
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Memorilo.TimeUtils

  embedded_schema do
    field :subject, :string
    field :content, :string
    field :to, :string
    field :delivery_time, :naive_datetime
  end

  @fields [:subject, :content, :to, :delivery_time]

  def changeset(delivery, params \\ %{}) do
    delivery
    |> cast(params, @fields)
    |> validate_required(@fields, message: "campo obrigatório")
    |> validate_format(:to, ~r/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/, message: "formato inválido")
    |> validate_delivery_time()
  end

  def changeset_empty(), do: change(%__MODULE__{}, %{})

  def changset_action_insert(delivery, params \\ %{}) do
    delivery
    |> changeset(params)
    |> Map.put(:action, :insert)
  end

  defp validate_delivery_time(%Ecto.Changeset{changes: %{delivery_time: delivery_time}} = changeset) do
    {:ok, %{date: date, time: time}} = TimeUtils.extract_date_and_time(delivery_time)
    {:ok, local_delivery_time} = DateTime.new(date, time, TimeUtils.default_time_zone())
    case DateTime.compare(local_delivery_time, TimeUtils.local_now()) do
      :lt -> add_error(changeset, :delivery_time, "Delivery date is in past.")
       _ -> changeset
    end
  end

  defp validate_delivery_time(changeset), do: changeset
end
