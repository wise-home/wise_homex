defmodule WiseHomex.Household do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :tenant, WiseHomex.Account
    belongs_to :address, WiseHomex.Address, type: :binary_id
    belongs_to :external_info, WiseHomex.ExternalInfo
    has_many :foreign_devices, WiseHomex.ForeignDevice
    has_many :tenancies, WiseHomex.Tenancy
    has_many :settlement_values, WiseHomex.SettlementValue
    has_many :unsuccessful_visits, WiseHomex.UnsuccessfulVisit

    # shared household config
    belongs_to :shared_settlement_key, WiseHomex.SettlementKey
    has_many :shared_to, WiseHomex.Household

    field :apartment, :string
    field :active_from, :date
    field :active_to, :date
    field :active, :boolean
    field :number, :integer
    field :virtual, :boolean
    field :standard_dk_sort, :integer
    field :business, :boolean
    field :taxable, :boolean
    field :excluded, :boolean
  end
end
