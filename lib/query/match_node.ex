defmodule Query.MatchNode do
  defstruct var: nil,
            label: nil,
            properties: %{}

  @type t() :: %__MODULE__{
          var: nil | binary(),
          label: nil | binary(),
          properties: %{required(binary()) => term()}
        }

  @spec new(binary(), binary(), %{required(binary()) => term()}) :: __MODULE__.t()
  def new(var, label, properties \\ %{}) do
    %__MODULE__{var: var, label: label, properties: properties}
  end
end
