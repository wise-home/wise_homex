defmodule WiseHomex.Device do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :room, WiseHomex.Room
    belongs_to :gateway, WiseHomex.Gateway
    belongs_to :device_type, WiseHomex.DeviceType
    field :serial, :string
    field :number, :string
    field :authorized_at, :utc_datetime
    field :online, :string
    field :installation_year, :integer
    field :last_seen, :utc_datetime
    field :inserted_at, :utc_datetime
    field :signal_strength, :integer
    field :protocol, :string

    embeds_many :signal_strength_history, Signal, primary_key: false do
      field :time, :utc_datetime
      field :signal_strength, :integer
    end
  end

  def household_id(%__MODULE__{room: %{household: %{id: id}}}), do: id
  def household_id(_), do: nil
end
