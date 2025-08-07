defmodule Query.MatchEdge do
  defstruct direction: nil,
            var: nil,
            label: nil,
            properties: %{}

  @type t_direction() :: :bidi | :forward | :backward

  @type t() :: %__MODULE__{
          direction: t_direction(),
          var: nil | binary(),
          label: nil | binary(),
          properties: %{required(binary()) => term()}
        }

  @spec new(t_direction(), binary(), binary(), %{required(binary()) => term()}) :: __MODULE__.t()
  def new(direction, var, label, properties \\ %{}) do
    %__MODULE__{direction: direction, var: var, label: label, properties: properties}
  end
end
