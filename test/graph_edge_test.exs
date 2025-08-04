defmodule Graph.Edge.Test do
  use ExUnit.Case
  doctest Graph.Edge

  test "new" do
    e = Graph.Edge.new(1, 2, 3, 4)
    assert e.source == 1
    assert e.destination == 2
    assert e.type == 3
    assert e.properties == 4
  end
end
