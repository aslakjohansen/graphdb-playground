defmodule Graph.Node.Test do
  use ExUnit.Case
  doctest Graph.Node

  test "new with defaults" do
    n = Graph.Node.new()
    assert n.incoming == %{}
    assert n.outgoing == %{}
    assert MapSet.size(n.labels) == 0
    assert length(Map.keys(n.properties)) == 0
  end

  test "new with incoming and outgoing" do
    n = Graph.Node.new(1, 2)
    assert n.incoming == 1
    assert n.outgoing == 2
  end

  test "adding incoming" do
    n =
      Graph.Node.new()
      |> Graph.Node.add_incoming("type1", 1)
      |> Graph.Node.add_incoming("type1", 2)
      |> Graph.Node.add_incoming("type2", 3)

    type1 = Map.get(n.incoming, "type1")
    type2 = Map.get(n.incoming, "type2")
    assert MapSet.member?(type1, 1)
    assert MapSet.member?(type1, 2)
    assert MapSet.member?(type2, 3)
    assert MapSet.size(type1) == 2
    assert MapSet.size(type2) == 1
  end

  test "adding outgoing" do
    n =
      Graph.Node.new()
      |> Graph.Node.add_outgoing("type1", 1)
      |> Graph.Node.add_outgoing("type1", 2)
      |> Graph.Node.add_outgoing("type2", 3)

    type1 = Map.get(n.outgoing, "type1")
    type2 = Map.get(n.outgoing, "type2")
    assert MapSet.member?(type1, 1)
    assert MapSet.member?(type1, 2)
    assert MapSet.member?(type2, 3)
    assert MapSet.size(type1) == 2
    assert MapSet.size(type2) == 1
  end

  test "removing incoming" do
    n =
      Graph.Node.new()
      |> Graph.Node.add_incoming("type1", 1)
      |> Graph.Node.add_incoming("type1", 2)
      |> Graph.Node.add_incoming("type2", 3)
      |> Graph.Node.remove_incoming("type1", 2)
      |> Graph.Node.remove_incoming("type2", 3)

    type1 = Map.get(n.incoming, "type1")
    type2 = Map.get(n.incoming, "type2")
    assert MapSet.member?(type1, 1)
    assert not MapSet.member?(type1, 2)
    assert MapSet.size(type1) == 1
    assert type2 == nil
  end

  test "removing outgoing" do
    n =
      Graph.Node.new()
      |> Graph.Node.add_outgoing("type1", 1)
      |> Graph.Node.add_outgoing("type1", 2)
      |> Graph.Node.add_outgoing("type2", 3)
      |> Graph.Node.remove_outgoing("type1", 2)
      |> Graph.Node.remove_outgoing("type2", 3)

    type1 = Map.get(n.outgoing, "type1")
    type2 = Map.get(n.outgoing, "type2")
    assert MapSet.member?(type1, 1)
    assert not MapSet.member?(type1, 2)
    assert MapSet.size(type1) == 1
    assert type2 == nil
  end
end
