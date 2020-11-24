defmodule WiseHomex.Measurement do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    field :measurement_at, :utc_datetime
    field :meter_type, :string
    field :value, WiseHomex.QuantityType
  end
end
