defmodule DebuglandTest do
  use ExUnit.Case
  doctest Debugland

  test "greets the world" do
    assert Debugland.hello() == :world
  end
end
