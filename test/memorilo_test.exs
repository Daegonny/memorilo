defmodule MemoriloTest do
  use ExUnit.Case
  doctest Memorilo

  test "greets the world" do
    assert Memorilo.hello() == :world
  end
end
