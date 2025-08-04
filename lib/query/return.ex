defmodule Query.Return do
  defstruct elements: []

  @type t() :: %Query.Return{elements: list(binary() | Query.Alias.t())}
end
