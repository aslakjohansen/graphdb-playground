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
    assert length(q.match) == 3
    [qmatch0, qmatch1, qmatch2] = q.match

    assert qmatch0 == %Query.MatchNode{
             var: "sensor",
             label: "Sensor",
             properties: %{"modality" => "temperature"}
           }

    assert qmatch1 == %Query.MatchEdge{
             direction: :forward,
             var: "edge",
             label: "hasLocation",
             properties: %{}
           }

    assert qmatch2 == %Query.MatchNode{var: "location", label: "Location", properties: %{}}
    assert q.omatch == nil
    assert q.where == {:eq, {:property, "sensor", "modality"}, {:string, "temperature"}}
    assert q.return == [%Query.Alias{full: "", as: ""}]
  end
end
