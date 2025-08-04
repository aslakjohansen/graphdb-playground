defmodule Link.Node do
  use GenServer
  alias Graph.Node, as: GraphNode

  # interface

  def start_link(name, properties, incoming, outgoing) do
    GenServer.start_link(__MODULE__, {properties, incoming, outgoing}, name: via_tuple(name))
  end

  # helpers

  def via_tuple(name) do
    {:via, Registry, {:link_node_registry, name}}
  end

  # callbacks

  @impl true
  def init({properties, incoming, outgoing}) do
    node = GraphNode.new(properties, incoming, outgoing)
    {:ok, %{node: node}}
  end
end
