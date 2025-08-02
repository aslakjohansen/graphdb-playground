defmodule Graph.Edge do
  defstruct source: nil, destination: nil

  def new(source, destination) do
    %Graph.Edge{source: source, destination: destination}
  end

  def set_source(edge, source) do
    %Graph.Edge{edge | source: source}
  end

  def set_destination(edge, destination) do
    %Graph.Edge{edge | destination: destination}
  end
end
