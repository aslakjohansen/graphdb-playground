defmodule Link.Edge do
  use GenServer
  alias Graph.Edge, as: GraphEdge

  # interface

  def start_link(name, label, properties, source, destination) do
    GenServer.start_link(__MODULE__, {label, properties, source, destination},
      name: via_tuple(name)
    )
  end

  # helpers

  def via_tuple(name) do
    {:via, Registry, {:link_edge_registry, name}}
  end

  # callbacks

  @impl true
  def init({label, properties, source, destination}) do
    Registry.register(:link_label2edges_registry, label, nil)

    edge = GraphEdge.new(source, destination, label, properties)
    {:ok, %{edge: edge}}
  end
end
