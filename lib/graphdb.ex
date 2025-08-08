defmodule Graphdb do
  def hello do
    {:ok, node_registry_pid} = Registry.start_link(name: :link_node_registry, keys: :unique)
    {:ok, edge_registry_pid} = Registry.start_link(name: :link_edge_registry, keys: :unique)

    {:ok, label2nodes_registry_pid} =
      Registry.start_link(name: :link_label2nodes_registry, keys: :duplicate)

    {:ok, label2edges_registry_pid} =
      Registry.start_link(name: :link_label2edges_registry, keys: :duplicate)

    node1_id = "node 1"
    node2_id = "node 2"
    edge1_id = "edge 1"

    {:ok, node1_pid} =
      Link.Node.start_link(node1_id, %{"modality" => "temperature"}, %{}, %{
        "hasLocation" => [edge1_id]
      })

    {:ok, edge1_pid} =
      Link.Edge.start_link(edge1_id, %{}, node1_id, node2_id)

    {:ok, node2_pid} =
      Link.Node.start_link(node2_id, %{}, %{"hasLocation" => [edge1_id]}, %{})

    {:ok,
     %{
       node_registry: node_registry_pid,
       edge_registry: edge_registry_pid,
       label2nodes_registry: label2nodes_registry_pid,
       label2edges_registry: label2edges_registry_pid,
       nodes: [node1_pid, node2_pid],
       edges: [edge1_pid]
     }}
  end
end
