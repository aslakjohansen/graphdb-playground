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
    initial_state = %{
      last: nil,
      bindings: %{}
    }

    _matched_bindings =
      query.match
      |> Enum.reduce(initial_state, fn match_element, _acc ->
        case match_element do
          %Query.MatchNode{var: _var, label: _label, properties: _properties} ->
            initial_state

          %Query.MatchEdge{
            direction: _direction,
            var: _var,
            label: _label,
            properties: _properties
          } ->
            initial_state

          _ ->
            initial_state
        end
      end)
  end
end
