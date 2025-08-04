defmodule Query.Match do
  @type t() :: Query.MatchNode.t() | Query.MatchBidi.t()
  # TODO: Another way of modeling this is to essentially have a list along the way of [node1, {:bidi, edge, node}, {:forward, edge, node}, {:backward, edge, node} ]
end
