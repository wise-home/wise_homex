defmodule WiseHomex.Expense do
  @moduledoc """
  Model for an Expense
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :fiscal_year, WiseHomex.FiscalYear, type: :binary_id

    field :accounting_date, :date
    field :company_name, :string
    field :fuel_type, :string
    field :partial, :boolean
    field :total_amount, WiseHomex.QuantityType
    field :usage, WiseHomex.QuantityType
    field :vat_amount, WiseHomex.QuantityType

    timestamps type: :utc_datetime
  end
end
