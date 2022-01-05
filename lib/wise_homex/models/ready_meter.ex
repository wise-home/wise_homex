defmodule WiseHomex.ReadyMeter do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :ready_installation, WiseHomex.ReadyInstallation
    belongs_to :device, WiseHomex.Device

    field :external_id, :integer
    field :consumption_type, :string
    field :manufacturer, :string
    field :meter_type, :string
    field :serial_number, :string

    field :last_sync_attempt_at, :utc_datetime
    field :last_measurement_from, :utc_datetime
  end
end
