defmodule WiseHomex.StatementConfig do
  @moduledoc """
  Model for a StatementConfig
  """

  alias WiseHomex.DecimalType
  alias WiseHomex.QuantityType

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :heat_transmission_key, WiseHomex.SettlementKey, type: :binary_id
    belongs_to :hot_water_transmission_key, WiseHomex.SettlementKey, type: :binary_id
    belongs_to :property, WiseHomex.Property

    field :company_number_length, :integer
    field :customer_reference, :string
    field :flatrate, :boolean
    field :hca_ratio, DecimalType
    field :heat_hca_ratio, DecimalType
    field :heat_transmission_ratio, DecimalType
    field :hot_water_heat_ratio, DecimalType
    field :hot_water_transmission_ratio, DecimalType
    field :household_number_length, :integer
    field :message_all, :string
    field :message_owed, :string
    field :message_reimbursement, :string
    field :moving_fee_on_tenancy, :boolean
    field :moving_fee_price, QuantityType
    field :pdf_naming_scheme, :string
    field :property_number_length, :integer
    field :settlement_file, :string
    field :tenancy_number_length, :integer
    field :tenancy_pdf_type, :string
  end
end
