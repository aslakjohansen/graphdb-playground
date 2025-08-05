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
    {_, where_part} = where_response = parse_where(where)
    {_, return_part} = return_response = parse_return(return)

    errors =
      [match_response, where_response, return_response]
      |> Enum.filter(fn {status, result} -> status == :error end)
      |> Enum.map(fn {_, message} -> message end)

    if length(errors) == 0 do
      {:ok, Query.MatchQuery.new(match_part, where_part, return_part)}
    else
      {:error, errors}
    end
  end
end
