defmodule Graph.Node do
  # Problem: incoming and outgoing are maps from type to edge set, but looking up the type of an edge requires a round-trip ... unless we already make that round-trip.
  defstruct labels: MapSet.new(), properties: %{}, incoming: %{}, outgoing: %{}

  def new(incoming, outgoing, labels \\ nil, properties \\ nil) do
    node = %Graph.Node{
      properties: properties,
      incoming: incoming,
      outgoing: outgoing
    }

    node =
      if labels == nil do
        node
      else
        %Graph.Node{node | labels: labels}
      end

    node =
      if properties == nil do
        node
      else
        %Graph.Node{node | properties: properties}
      end

    node
  end

  def add_incoming(node, edge) do
    %Graph.Node{node | incoming: [edge | node.incoming]}
  end

  def add_outgoing(node, edge) do
    %Graph.Node{node | outgoing: [edge | node.outgoing]}
  end

  def remove_incoming(node, edge) do
    %Graph.Node{node | incoming: List.delete(node.incoming, edge)}
  end

  def remove_outgoing(node, edge) do
    %Graph.Node{node | outgoing: List.delete(node.outgoing, edge)}
  end
end
