defmodule Query.Parser.JSON.Test do
  use ExUnit.Case
  doctest Query.Parser.JSON

  test "" do
    case = """
    {
      "match" => [
        {
          "type": "node",
          "var": "name",
          "type": "sensor"
        }
      ],
      "where" => {
        "op" => "eq",
        "lhs" => {
          "type" => "property",
          "var" => "name",
          "field" => "modality"
        },
        "rhs" => "temperature"
      },
      "return" => [
        {"full" => "", "as" => ""},
      ]
    }
    """

    q = Query.Parser.JSON.parse(case)
    IO.inspect(q)
  end
end
