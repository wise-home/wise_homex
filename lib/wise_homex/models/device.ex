defmodule WiseHomex.Device do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :room, WiseHomex.Room
    belongs_to :gateway, WiseHomex.Gateway
    belongs_to :device_type, WiseHomex.DeviceType
    belongs_to :heat_source, WiseHomex.HeatSource
    field :authorized_at, :utc_datetime
    field :exclude_from_statements, :boolean
    field :inserted_at, :utc_datetime
    field :installation_year, :integer
    field :last_seen, :utc_datetime
    field :number, :string
    field :online, :string
    field :protocol, :string
    field :reduction_factor, WiseHomex.DecimalType
    field :serial, :string
    field :signal_strength, :integer

    embeds_many :signal_strength_history, Signal, primary_key: false do
      field :time, :utc_datetime
      field :signal_strength, :integer
    end
  end

  def household_id(%__MODULE__{room: %{household: %{id: id}}}), do: id
  def household_id(_), do: nil
end
