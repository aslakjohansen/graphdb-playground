defmodule Link.Node do
  use GenServer
  alias Graph.Node, as: GraphNode

  # interface

  def start_link(name, labels, properties, incoming, outgoing) do
    GenServer.start_link(__MODULE__, {labels, properties, incoming, outgoing},
      name: via_tuple(name)
    )
  end

  # helpers

  def via_tuple(name) do
    {:via, Registry, {:link_node_registry, name}}
  end

  # callbacks

  @impl true
  def init({labels, properties, incoming, outgoing}) do
    Enum.map(labels, fn label -> Registry.register(:link_label2nodes_registry, label, nil) end)

    node = GraphNode.new(properties, incoming, outgoing)
    {:ok, %{node: node}}
  end
end
