defmodule WiseHomex.DSEnergyLocation do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :ds_energy_group, WiseHomex.DSEnergyGroup
    belongs_to :household, WiseHomex.Household
    belongs_to :room, WiseHomex.Room

    field :customer_name, :string
    field :location_name, :string
    field :full_location, :string
    field :full_location_name, :string

    field :parent_full_location, :string

    field :depth, :integer

    has_many :ds_energy_meters, WiseHomex.DSEnergyMeter
  end
end
