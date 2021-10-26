defmodule WiseHomex.UtilityReading do
  @moduledoc """
  Measurement, but saved for each 14-days period.
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :device, WiseHomex.Device

    field :calculation_method, :string
    field :converted_value, WiseHomex.QuantityType
    field :measurement_at, :utc_datetime
    field :meter_type, :string
    field :needs_review, :boolean
    field :reading_type, :string
    field :target_date, :date
    field :value, WiseHomex.QuantityType
  end
end
