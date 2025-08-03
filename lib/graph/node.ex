defmodule Graph.Node do
  # Problem: incoming and outgoing are maps from type to edge set, but looking up the type of an edge requires a round-trip ... unless we already make that round-trip.

  defstruct labels: MapSet.new(), properties: %{}, incoming: %{}, outgoing: %{}

  def new(incoming \\ %{}, outgoing \\ %{}, labels \\ nil, properties \\ nil) do
    node = %Graph.Node{
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

  def add_incoming(node, type, edge) do
    set =
      Map.get(node.incoming, type, MapSet.new())
      |> MapSet.put(edge)

    %Graph.Node{node | incoming: Map.put(node.incoming, type, set)}
  end

  def add_outgoing(node, type, edge) do
    set =
      Map.get(node.outgoing, type, MapSet.new())
      |> MapSet.put(edge)

    %Graph.Node{node | outgoing: Map.put(node.outgoing, type, set)}
  end

  def remove_incoming(node, type, edge) do
    set =
      Map.get(node.incoming, type, MapSet.new())
      |> MapSet.delete(edge)

    if MapSet.size(set) == 0 do
      Map.put(node, :incoming, Map.delete(node.incoming, type))
    else
      %Graph.Node{node | incoming: Map.put(node.incoming, type, set)}
    end
  end

  def remove_outgoing(node, type, edge) do
    set =
      Map.get(node.outgoing, type, MapSet.new())
      |> MapSet.delete(edge)

    if MapSet.size(set) == 0 do
      Map.put(node, :outgoing, Map.delete(node.outgoing, type))
    else
      %Graph.Node{node | outgoing: Map.put(node.outgoing, type, set)}
    end
  end
end
