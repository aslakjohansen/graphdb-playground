defmodule Query.Alias do
  defstruct full: nil,
            as: nil

  @type t() :: %__MODULE__{full: binary(), as: binary()}

  @spec new(binary(), binary()) :: __MODULE__.t()
  def new(full, as) do
    %Query.Alias{full: full, as: as}
  end
end
