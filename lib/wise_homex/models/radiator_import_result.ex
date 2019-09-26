defmodule WiseHomex.RadiatorImportResult do
  @moduledoc """
  Result from a radiator import
  """

  use WiseHomex.BaseModel

  embedded_schema do
    field :count, :integer
  end
end
