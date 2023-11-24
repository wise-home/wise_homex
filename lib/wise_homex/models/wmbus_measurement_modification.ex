defmodule WiseHomex.WMBusMeasurementModification do
  @moduledoc """
    A WMBus measurement modification is a correction of a MeasurementInfo, before it is persisted in the database.
  """
  use WiseHomex.BaseModel

  embedded_schema do
    field :device_serial, :string
    field :multiplier, :decimal
    field :correction_reason, :string
    field :active_from, :utc_datetime
    field :active_to, :utc_datetime
  end
end
