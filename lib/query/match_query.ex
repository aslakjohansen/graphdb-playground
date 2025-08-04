defmodule Query.MatchQuery do
  defstruct match: nil,
            omatch: nil,
            where: nil,
            return: nil

  @type t() :: %Query.MatchQuery{
          match: Query.Match.t(),
          omatch: Query.Match.t(),
          where: Query.Expr.t(),
          return: list(binary() | Query.Alias.t())
        }
end
