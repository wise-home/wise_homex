defmodule WiseHomex.Device do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to(:room, WiseHomex.Room)
    belongs_to(:gateway, WiseHomex.Gateway)
    belongs_to(:device_type, WiseHomex.DeviceType)
    field(:serial, :string)
    field(:number, :string)
    field(:authorized_at, :utc_datetime)
    field(:online, :string)
    field(:installation_year, :integer)
    field(:last_seen, :utc_datetime)
    field(:inserted_at, :utc_datetime)
    field(:signal_strength, :integer)
    field(:signal_strength_history, {:array, :map})
    field(:protocol, :string)
  end

  def household_id(%__MODULE__{room: %{household: %{id: id}}}), do: id
  def household_id(_), do: nil
end
