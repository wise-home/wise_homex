defmodule WiseHomex.ForeignDevice do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :household, WiseHomex.Household
    belongs_to :room, WiseHomex.Room
    belongs_to :heat_source, WiseHomex.HeatSource, type: :binary_id
    belongs_to :device, WiseHomex.Device

    field :start_date, :date
    field :end_date, :date
    field :start_value, WiseHomex.QuantityType
    field :end_value, WiseHomex.QuantityType

    field :meter_type, :string
    field :reading_type, :string
    field :number, :string
    field :hot_water_heat_meter, :boolean
  end
end
