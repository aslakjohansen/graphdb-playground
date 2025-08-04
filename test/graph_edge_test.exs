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

  test "adding properties" do
    e =
      Graph.Edge.new(1, 2, 3)
      |> Graph.Edge.add_property("prop1", "value1")
      |> Graph.Edge.add_property("prop2", "value2")

    assert Map.get(e.properties, "prop1") == "value1"
    assert Map.get(e.properties, "prop2") == "value2"
    assert length(Map.keys(e.properties)) == 2

    e = Graph.Edge.add_property(e, "prop2", "value3")

    assert Map.get(e.properties, "prop1") == "value1"
    assert Map.get(e.properties, "prop2") == "value3"
    assert length(Map.keys(e.properties)) == 2
  end

  test "removing properties" do
    e =
      Graph.Edge.new(1, 2, 3)
      |> Graph.Edge.add_property("prop1", "value1")
      |> Graph.Edge.add_property("prop2", "value2")
      |> Graph.Edge.remove_property("prop1")

    assert Map.get(e.properties, "prop2") == "value2"
    assert length(Map.keys(e.properties)) == 1

    e = Graph.Edge.remove_property(e, "prop2")

    assert length(Map.keys(e.properties)) == 0
  end
end
