defmodule Query.Parser.JSON do
  @spec parse(binary()) :: Query.MatchQuery.t()
  def parse(input) do
    {:ok, data} = Jason.decode(input)
    data
  end
end
