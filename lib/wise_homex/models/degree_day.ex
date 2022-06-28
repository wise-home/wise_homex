defmodule WiseHomex.DegreeDay do
  @moduledoc false

  use WiseHomex.BaseModel

  alias WiseHomex.DecimalType

  embedded_schema do
    field :date, :date
    field :value, DecimalType
  end
end
