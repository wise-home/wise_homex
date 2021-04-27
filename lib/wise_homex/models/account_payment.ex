defmodule WiseHomex.AccountPayment do
  @moduledoc """
  Model for an account payment
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :tenancy, WiseHomex.Tenancy, type: :binary_id
    belongs_to :fiscal_year, WiseHomex.FiscalYear, type: :binary_id
    field :accounting_date, :date
    field :excluded, :boolean
    field :q_total_amount, WiseHomex.QuantityType
    field :q_vat_amount, WiseHomex.QuantityType

    timestamps type: :utc_datetime
  end
end
