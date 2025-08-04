defmodule Graph.Edge do
  defstruct type: "",
            properties: %{},
            source: nil,
            destination: nil

  def new(source, destination, type, properties) do
    %Graph.Edge{
      type: type,
      properties: properties,
      source: source,
      destination: destination
    }
  end

  def set_source(edge, source) do
    %Graph.Edge{edge | source: source}
  end

  def set_destination(edge, destination) do
    %Graph.Edge{edge | destination: destination}
  end

  def add_property(edge, key, value) do
    %Graph.Edge{edge | properties: Map.put(edge.properties, key, value)}
  end

  def remove_property(edge, key) do
    %Graph.Edge{edge | properties: Map.delete(edge.properties, key)}
  end
end
