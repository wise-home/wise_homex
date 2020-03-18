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
    field :flatrate, :boolean
    field :hca_ratio, DecimalType
    field :heat_transmission_cost, DecimalType
    field :hot_water_heat_ratio, DecimalType
    field :hot_water_transmission_cost, DecimalType
    field :household_number_length, :integer
    field :moving_fee_on_tenancy, :boolean
    field :moving_fee_price, QuantityType
    field :property_number_length, :integer
    field :settlement_file, :string
    field :tenancy_number_length, :integer
    field :tenancy_pdf_type, :string
  end
end
