defmodule WiseHomex.KEMInfo do
  @moduledoc """
  Info from a Kamstrup KEM file
  """

  use WiseHomex.BaseModel

  embedded_schema do
    field(:serial, :string)
  end
end
