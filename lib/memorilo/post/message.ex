defmodule Memorilo.Post.Message do
  @moduledoc """
  Defines a message struct
  """
  defstruct subject: nil, content: nil, to: nil

  def new(subject, content, to) do
    %__MODULE__{
      subject: subject,
      content: content,
      to: to,
    }
  end
end
