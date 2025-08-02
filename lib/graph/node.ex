defmodule Graph.Node do
  defstruct incoming: [], outgoing: []

  def new(incoming, outgoing) do
    %Graph.Node{incoming: incoming, outgoing: outgoing}
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
