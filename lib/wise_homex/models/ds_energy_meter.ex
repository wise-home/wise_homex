defmodule WiseHomex.DSEnergyMeter do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :ds_energy_group, WiseHomex.DSEnergyGroup

    field :meter_id, :string
    field :friendly_name, :string
    field :meter_type, :string
    field :comment, :string
    field :alarm_email, :string
    field :location_name, :string
    field :full_location_name, :string
    field :full_location_id, :string
    field :customer_name, :string
    field :measuring_unit_symbol, :string

    field :last_ready_sync_attempt_at, :utc_datetime
    field :last_ready_measurement_from, :utc_datetime
  end
end
