defmodule WiseHomex.Household do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :tenant, WiseHomex.Account
    belongs_to :address, WiseHomex.Address, type: :binary_id
    has_many :external_households, WiseHomex.ExternalHousehold
    has_many :foreign_devices, WiseHomex.ForeignDevice
    has_many :tenancies, WiseHomex.Tenancy
    has_many :vacancies, WiseHomex.Vacancy
    has_many :rooms, WiseHomex.Room
    has_many :settlement_values, WiseHomex.SettlementValue
    has_many :unsuccessful_visits, WiseHomex.UnsuccessfulVisit
    has_many :broken_account_payments, WiseHomex.BrokenAccountPayment
    has_one :ready_installation, WiseHomex.ReadyInstallation
    has_one :ds_energy_location, WiseHomex.DSEnergyLocation

    # shared household config
    belongs_to :shared_settlement_key, WiseHomex.SettlementKey
    has_many :shared_to, WiseHomex.Household

    # household_id added to silence warning, about missing field, because shared_to is a reference to the same model
    # the field (household_id) is not used in the schema. 
    field :household_id, :integer
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

    field :excluded_fiscal_years, {:array, :string}
    field :remaining_usage, {:array, :string}
  end
end
