defmodule WiseHomex.DSEnergyLocationMatch do
  @moduledoc false

  use WiseHomex.BaseModel

  alias WiseHomex.Household
  alias WiseHomex.DSEnergyLocation

  embedded_schema do
    belongs_to :household, Household
    belongs_to :ds_energy_location, DSEnergyLocation, type: :binary_id

    field :distance, :integer
  end
end
