defmodule WiseHomex.Household do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :tenant, WiseHomex.Account
    belongs_to :address, WiseHomex.Address, type: :binary_id
    belongs_to :external_info, WiseHomex.ExternalInfo
    has_many :tenancies, WiseHomex.Tenancy
    has_many :settlement_values, WiseHomex.SettlementValue

    field :apartment, :string
    field :active_from, :date
    field :active_to, :date
    field :active, :boolean
    field :virtual, :boolean
  end
end
