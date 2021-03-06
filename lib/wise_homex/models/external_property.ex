defmodule WiseHomex.ExternalProperty do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :property, WiseHomex.Property
    has_many :external_households, WiseHomex.ExternalHousehold

    field :system, :string
    field :number, :integer
    field :company_number, :integer
    field :synced, :boolean
    field :last_synced_at, :utc_datetime
    field :sync_method, :string
  end
end
