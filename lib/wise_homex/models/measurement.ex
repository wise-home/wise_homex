defmodule WiseHomex.Measurement do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    field :measurement_at, :utc_datetime
    field :meter_type, :string

    field :base_value, :integer
    # Base 10
    field :exponent, :integer
    field :unit, :string
  end
end
