defmodule Memorilo.Post.Delivery do
  @moduledoc """
  Defines a Delivery struct with message and delivery_time
  """
  alias Memorilo.Post.Message

  defstruct message: nil, delivery_time: nil

  def new(subject, content, to, delivery_time) do
    %__MODULE__{
      message: Message.new(subject, content, to),
      delivery_time: delivery_time
    }
  end
end
