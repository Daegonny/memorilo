defmodule Memorilo.Post.Message do
  @moduledoc """
  Defines a message struct
  """
  defstruct from: nil, to: nil, content: nil

  def new(from, to, content) do
    %__MODULE__{
      from: from,
      to: to,
      content: content
    }
  end
end
