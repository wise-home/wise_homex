defmodule WiseHomex.Expense do
  @moduledoc """
  Model for an Expense
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :fiscal_year, WiseHomex.FiscalYear, type: :binary_id

    field :accounting_date, :date
    field :company_name, :string
    field :currency, :string
    field :exponent, :integer
    field :fuel_type, :string
    field :quantity, :integer
    field :total_amount, :integer
    field :unit, :string
    field :vat_amount, :integer

    timestamps type: :utc_datetime
  end
end
