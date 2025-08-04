defmodule Query.MatchBidi do
  defstruct lhs: nil,
            rhs: nil,
            var: nil,
            label: nil,
            properties: %{}

  @type t() :: %Query.MatchBidi{
          lhs: Query.MatchNode.t(),
          rhs: Query.MatchNode.t(),
          var: nil | binary(),
          label: nil | binary(),
          properties: %{required(binary()) => term()}
        }
end
