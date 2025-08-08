defmodule Query.MatchQuery do
  defstruct match: nil,
            where: nil,
            return: nil,
            omatch: nil

  @type t() :: %Query.MatchQuery{
          match: Query.Match.t(),
          where: Query.Expr.t(),
          return: list(binary() | Query.Alias.t()),
          omatch: Query.Match.t()
        }

  @spec new(Query.Match.t(), Query.Expr.t(), list(Query.Alias.t()), Query.Match.t() | nil) ::
          __MODULE__.t()
  def new(match, where, return, omatch \\ nil) do
    %__MODULE__{match: match, where: where, return: return, omatch: omatch}
  end

  def evaluate(query) do
  end
end
