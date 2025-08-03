defmodule Graph.Node.Test do
  use ExUnit.Case
  doctest Graph.Node

  test "new with defaults" do
    n = Graph.Node.new(1, 2)
    assert n.incoming == 1
    assert n.outgoing == 2
    assert MapSet.size(n.labels)==0
    assert length(Map.keys(n.properties))==0
  end
end
