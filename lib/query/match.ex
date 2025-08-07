defmodule Query.Match do
  @type t_node_element() :: Query.MatchNode.t()
  @type t_edge_element() :: Query.MatchBidi.t()
  @type t() :: list(t_node_element() | t_edge_element())
end
