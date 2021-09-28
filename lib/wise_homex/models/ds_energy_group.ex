defmodule WiseHomex.DSEnergyGroup do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    field :name, :string
    field :api_key, :string
    field :sync, :boolean

    has_many :ds_energy_locations, WiseHomex.DSEnergyLocation
  end
end
