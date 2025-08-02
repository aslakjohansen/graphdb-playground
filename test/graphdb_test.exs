defmodule GraphdbTest do
  use ExUnit.Case
  doctest Graphdb

  test "greets the world" do
    assert Graphdb.hello() == :world
  end
end
