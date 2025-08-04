defmodule Query.MatchNode do
  defstruct var: nil,
            label: nil,
            properties: %{}

  @type t() :: %__MODULE__{
          var: nil | binary(),
          label: nil | binary(),
          properties: %{required(binary()) => term()}
        }
end
