defmodule WiseHomex.StatementConfig do
  @moduledoc """
  Model for a StatementConfig
  """

  alias WiseHomex.DecimalType
  alias WiseHomex.QuantityType

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :statement, WiseHomex.Statement

    belongs_to :electricity_settlement_key, WiseHomex.SettlementKey, type: :binary_id
    belongs_to :heat_settlement_key, WiseHomex.SettlementKey, type: :binary_id
    belongs_to :heat_transmission_key, WiseHomex.SettlementKey, type: :binary_id
    belongs_to :hot_water_settlement_key, WiseHomex.SettlementKey, type: :binary_id
    belongs_to :hot_water_transmission_key, WiseHomex.SettlementKey, type: :binary_id
    belongs_to :water_settlement_key, WiseHomex.SettlementKey, type: :binary_id

    field :company_number_length, :integer
    field :customer_reference, :string
    field :electricity_settlement_key_end_date, :date
    field :hca_ratio, DecimalType
    field :heat_hca_ratio, DecimalType
    field :heat_settlement_key_end_date, :date
    field :heat_transmission_ratio, DecimalType
    field :hot_water_heat_ratio, DecimalType
    field :hot_water_settlement_key_end_date, :date
    field :hot_water_transmission_ratio, DecimalType
    field :household_number_length, :integer
    field :ignore_foreign_devices_hot_water, :boolean
    field :ignore_foreign_devices_cold_water, :boolean
    field :ignore_foreign_devices_heat_cost, :boolean
    field :ignore_foreign_devices_heat_energy, :boolean
    field :ignore_foreign_devices_electricity_energy, :boolean
    field :message_all, :string
    field :message_owed, :string
    field :message_reimbursement, :string
    field :moving_fee_on_tenancy, :boolean
    field :moving_fee_price, QuantityType
    field :pdf_naming_scheme, :string
    field :property_number_length, :integer
    field :settlement_file, :string
    field :sorting, :string
    field :tenancy_number_length, :integer
    field :tenancy_pdf_type, :string
    field :water_settlement_key_end_date, :date
  end

  @doc """
  Available values for :pdf_naming_scheme
  """
  def pdf_naming_scheme_options(), do: ["wise_home", "unik"]

  @doc """
  Available values for :sorting
  """
  def settlement_file_options(), do: ["unik", "unik_with_sums", "eg"]

  @doc """
  Available values for :sorting
  """
  def sorting_options(), do: ["default", "moved_out_last", "wise_home_only"]

  @doc """
  Available values for :tenancy_pdf_type
  """
  def tenancy_pdf_type_options(), do: ["concatenated", "merged", "all"]
end
