defmodule Graph.Registry do
  def start_link() do
    Registry.start_link(keys: :unique, name: __MODULE__)
  end

  def register(name, value) do
    Registry.register(__MODULE__, name, value)
  end

  def unregister(name) do
    Registry.unregister(__MODULE__, name)
  end

  def lookup(name) do
    Registry.lookup(__MODULE__, name)
  end
end
