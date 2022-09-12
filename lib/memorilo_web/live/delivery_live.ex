defmodule MemoriloWeb.DeliveryLive do
  use MemoriloWeb, :live_view
  alias Memorilo
  alias Memorilo.Post.Delivery

  def mount(_parms, _session, socket) do
    {:ok, assign(socket,
      [
        changeset: Delivery.changeset_empty(),
        subject: nil
      ]
    )}
  end

  def handle_event("schedule", %{"delivery" => params}, socket) do
    changeset = Delivery.changset_action_insert(%Delivery{}, params)
    if changeset.valid? do
      schedule_message(changeset, params, socket)
    else
      {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp schedule_message(changeset, params, socket) do
    delivery = Ecto.Changeset.apply_changes(changeset)
    Memorilo.schedule_message(delivery)
    socket = assign(socket,
      [
        changeset: Delivery.changeset_empty(),
        subject: params["subject"]
      ]
    )
    {:noreply, socket}
  end
end
