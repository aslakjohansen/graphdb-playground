defmodule Query.Alias do
  defstruct full: nil,
            as: nil

  @type t() :: %Query.Alias{full: binary(), as: binary()}
end
