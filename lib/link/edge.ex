defmodule Link.Edge do
  use GenServer
  alias Graph.Edge, as: GraphEdge

  # interface

  def start_link(name, properties, source, destination) do
    GenServer.start_link(__MODULE__, {properties, source, destination}, name: via_tuple(name))
  end

  # helpers

  def via_tuple(name) do
    {:via, Registry, {:link_edge_registry, name}}
  end

  # callbacks

  @impl true
  def init({properties, source, destination}) do
    edge = GraphEdge.new(properties, source, destination)
    {:ok, %{edge: edge}}
  end
end
