defmodule WiseHomex.Gateway do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :admin, WiseHomex.Account
    belongs_to :sim, WiseHomex.Sim
    field :serial, :string
    field :address, :string
    field :location, :string
    field :notes, :string
    field :last_connect_at, :utc_datetime
    field :software_version, :string
    field :online, :string
    field :unlocked_at, :utc_datetime
    field :unlocked_seconds, :integer
    field :enabled_modules, {:array, :string}, default: []
    field :skip_offline_report, :boolean
    field :activated, :boolean
  end
end
