defmodule WiseHomex.ExternalTenancy do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :tenancy, WiseHomex.Tenancy, type: :binary_id
    belongs_to :external_household, WiseHomex.ExternalHousehold, type: :binary_id

    field :system, :string
    field :external_id, :string
    field :number, :integer
    field :synced, :boolean
    field :last_synced_at, :utc_datetime
    field :payments_synced, :boolean
    field :payments_last_synced_at, :utc_datetime
  end
end
