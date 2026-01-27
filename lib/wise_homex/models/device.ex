defmodule WiseHomex.Device do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :room, WiseHomex.Room
    belongs_to :gateway, WiseHomex.Gateway
    belongs_to :device_type, WiseHomex.DeviceType
    belongs_to :heat_source, WiseHomex.HeatSource
    belongs_to :serial_connected_to, WiseHomex.Device
    has_many :serial_connected_from, WiseHomex.Device

    # device_id added to silence warning, about missing field, because serial_connected_from is a reference to the same model
    # the field (device_id) is not used in the schema.
    field :device_id, :integer

    field :active_from, :date
    field :active_to, :date
    field :attached_to_number, :string
    field :attached_to_serial, :string
    field :authorized_at, :utc_datetime
    field :exclude_from_statements, :boolean
    field :has_encryption_key, :boolean
    field :hot_water_heat_meter, :boolean
    field :inserted_at, :utc_datetime
    field :last_seen, :utc_datetime
    field :number, :string
    field :online, :string
    field :protocol, :string
    field :reduction_factor, WiseHomex.DecimalType
    field :serial, :string
    field :signal_strength, :integer
    field :unmanaged, :boolean
    field :encrypted, :boolean

    # Fields for water and heat meters
    field :hourly_flow, :string
    field :physical_size, :string
    field :pipe_size, :string
    field :stopcock, :boolean

    # Fields for heat_cost allocators
    field :hca_scale, :string
    field :hca_reduction_embedded, :boolean
    field :conversion_factor, WiseHomex.DecimalType

    has_many :last_measurements, WiseHomex.Measurement

    has_many :external_resources, WiseHomex.ExternalResource

    has_one :ready_meter, WiseHomex.ReadyMeter

    has_one :ds_energy_meter, WiseHomex.DSEnergyMeter

    embeds_many :signal_strength_history, Signal, primary_key: false do
      field :time, :utc_datetime
      field :signal_strength, :integer
    end
  end

  def household_id(%__MODULE__{room: %{household: %{id: id}}}), do: id
  def household_id(_), do: nil
end
