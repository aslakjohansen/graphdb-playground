defmodule Graphdb do
  def hello do
    {:ok, node_registry_pid} = Registry.start_link(name: :link_node_registry, keys: :unique)

    node1_id = "node 1"
    edge1_id = "edge 1"

    {:ok, node1_pid} =
      Link.Node.start_link(node1_id, %{"modality" => "temperature"}, %{}, %{
        "hasLocation" => [edge1_id]
      })
  end
end
