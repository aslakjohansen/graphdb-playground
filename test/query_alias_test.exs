defmodule Query.Alias.Test do
  use ExUnit.Case
  doctest Query.Alias

  test "new" do
    a = Query.Alias.new("a", "b")
    assert a.full == "a"
    assert a.as == "b"
  end
end
