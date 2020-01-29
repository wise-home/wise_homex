defmodule WiseHomex.UtilityReading do
  @moduledoc """
  Measurement, but saved for each 14-days period.
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :device, WiseHomex.Device
    belongs_to :room, WiseHomex.Room

    field :measurement_at, :utc_datetime
    field :target_date, :date
    field :meter_type, :string
    field :reading_type, :string
    field :value, WiseHomex.QuantityType
  end
end
