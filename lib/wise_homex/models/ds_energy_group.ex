defmodule WiseHomex.DSEnergyGroup do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :admin, WiseHomex.Account

    field :name, :string
    field :api_key, :string
    field :sync, :boolean

    has_many :ds_energy_meters, WiseHomex.DSEnergyMeter
  end
end
