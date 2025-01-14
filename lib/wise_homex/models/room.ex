defmodule WiseHomex.Room do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :household, WiseHomex.Household

    field :name, :string

    has_one :reduction_factor, WiseHomex.ReductionFactor
    has_one :thermal_info, WiseHomex.ThermalInfo

    has_many :heat_sources, WiseHomex.HeatSource
    has_many :tap_places, WiseHomex.TapPlace
  end
end
