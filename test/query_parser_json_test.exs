defmodule Query.Parser.JSON.Test do
  use ExUnit.Case
  doctest Query.Parser.JSON

  test "" do
    case = """
    {
      "match": [
        {
          "type": "node",
          "var": "sensor",
          "label": "Sensor",
          "properties": {
            "modality": "temperature"
          }
        },
        {
          "type": "edge",
          "direction": "forward",
          "var": "edge",
          "label": "hasLocation",
          "properties": {
          }
        },
        {
          "type": "node",
          "var": "location",
          "label": "Location",
          "properties": {
          }
        }
      ],
      "where": {
        "op": "eq",
        "lhs": {
          "type": "property",
          "var": "sensor",
          "field": "modality"
        },
        "rhs": "temperature"
      },
      "return": [
        {"full": "", "as": ""}
      ]
    }
    """

    {:ok, q} = Query.Parser.JSON.parse(case)
    IO.inspect(q)
  end
end
