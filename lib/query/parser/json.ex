defmodule Query.Parser.JSON do
  @spec parse(binary()) :: Query.MatchQuery.t()
  def parse(input) do
    input
    |> Jason.decode()
    |> parse_match_query()
  end

  # helpers

  defp parse_match_query({:error, _} = data) do
    data
  end

  defp parse_match_query({:ok, %{"match" => match, "where" => where, "return" => return}}) do
    {_, match_part} = match_response = parse_match(match)
    {_, where_part} = where_response = parse_expr(where)
    {_, return_part} = return_response = parse_return(return)

    errors =
      [match_response, where_response, return_response]
      |> Enum.filter(fn {status, _} -> status == :error end)
      |> Enum.map(fn {_, message} -> message end)

    if length(errors) == 0 do
      {:ok, Query.MatchQuery.new(match_part, where_part, return_part)}
    else
      {:error, errors}
    end
  end

  defp parse_expr(value) when is_binary(value) do
    {:string, value}
  end

  defp parse_expr(%{"op" => "and", "lhs" => lhs, "rhs" => rhs}) do
    {:and, parse_expr(lhs), parse_expr(rhs)}
  end

  defp parse_expr(%{"op" => "or", "lhs" => lhs, "rhs" => rhs}) do
    {:or, parse_expr(lhs), parse_expr(rhs)}
  end

  defp parse_expr(%{"op" => "eq", "lhs" => lhs, "rhs" => rhs}) do
    {:eq, parse_expr(lhs), parse_expr(rhs)}
  end

  defp parse_expr(%{"op" => "qeq", "lhs" => lhs, "rhs" => rhs}) do
    {:geq, parse_expr(lhs), parse_expr(rhs)}
  end

  defp parse_expr(%{"op" => "leq", "lhs" => lhs, "rhs" => rhs}) do
    {:leq, parse_expr(lhs), parse_expr(rhs)}
  end

  defp parse_expr(%{"op" => "gt", "lhs" => lhs, "rhs" => rhs}) do
    {:gt, parse_expr(lhs), parse_expr(rhs)}
  end

  defp parse_expr(%{"op" => "lt", "lhs" => lhs, "rhs" => rhs}) do
    {:lt, parse_expr(lhs), parse_expr(rhs)}
  end

  defp parse_return([]) do
    []
  end

  defp parse_return([%{"full" => full, "as" => as} | tail]) do
    [Query.Alias.new(full, as) | parse_return(tail)]
  end
end
