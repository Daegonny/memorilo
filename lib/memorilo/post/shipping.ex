defmodule Memorilo.Post.Shipping do
  @moduledoc """
  Defines a shipping struct with message and delivery_time
  """
  alias Memorilo.Post.Message

  defstruct message: nil, delivery_time: nil

  def new(from, to, content, delivery_time) do
    %__MODULE__{
      message: Message.new(from, to, content),
      delivery_time: delivery_time
    }
  end
end
