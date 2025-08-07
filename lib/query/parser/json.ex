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

  defp parse_match([]) do
    {:ok, []}
  end

  defp parse_match([
         %{"type" => "node", "var" => var, "label" => label, "properties" => properties} | rest
       ]) do
    {rest_status, rest_result} = parse_match(rest)

    cond do
      rest_status == :error ->
        {rest_status, rest_result}

      true ->
        {:ok, [Query.MatchNode.new(var, label, properties) | rest_result]}
    end
  end

  defp parse_match([
         %{
           "type" => "edge",
           "direction" => direction,
           "var" => var,
           "label" => label,
           "properties" => properties
         }
         | rest
       ]) do
    {rest_status, rest_result} = parse_match(rest)

    cond do
      rest_status == :error ->
        {rest_status, rest_result}

      Enum.member?(["bidi", "forward", "backward"], direction) ->
        direction = String.to_atom(direction)

        {:ok, [Query.MatchEdge.new(direction, var, label, properties) | rest_result]}

      true ->
        {:error, "Direction not allowed"}
    end
  end

  defp parse_expr(whatever) do
    try do
      {:ok, parse_expr!(whatever)}
    rescue
      _ -> {:error, "Unable to parse expression"}
    end
  end

  defp parse_expr!(value) when is_binary(value) do
    {:string, value}
  end

  defp parse_expr!(%{"type" => "property", "var" => var, "field" => field})
       when is_binary(var) and is_binary(field) do
    {:property, var, field}
  end

  defp parse_expr!(%{"op" => "and", "lhs" => lhs, "rhs" => rhs}) do
    {:and, parse_expr!(lhs), parse_expr!(rhs)}
  end

  defp parse_expr!(%{"op" => "or", "lhs" => lhs, "rhs" => rhs}) do
    {:or, parse_expr!(lhs), parse_expr!(rhs)}
  end

  defp parse_expr!(%{"op" => "eq", "lhs" => lhs, "rhs" => rhs}) do
    {:eq, parse_expr!(lhs), parse_expr!(rhs)}
  end

  defp parse_expr!(%{"op" => "qeq", "lhs" => lhs, "rhs" => rhs}) do
    {:geq, parse_expr!(lhs), parse_expr!(rhs)}
  end

  defp parse_expr!(%{"op" => "leq", "lhs" => lhs, "rhs" => rhs}) do
    {:leq, parse_expr!(lhs), parse_expr!(rhs)}
  end

  defp parse_expr!(%{"op" => "gt", "lhs" => lhs, "rhs" => rhs}) do
    {:gt, parse_expr!(lhs), parse_expr!(rhs)}
  end

  defp parse_expr!(%{"op" => "lt", "lhs" => lhs, "rhs" => rhs}) do
    {:lt, parse_expr!(lhs), parse_expr!(rhs)}
  end

  defp parse_return([]) do
    {:ok, []}
  end

  defp parse_return([%{"full" => full, "as" => as} | rest]) do
    {rest_status, rest_result} = parse_match(rest)

    cond do
      rest_status == :error ->
        {rest_status, rest_result}

      true ->
        {:ok, [Query.Alias.new(full, as) | rest_result]}
    end
  end
end
