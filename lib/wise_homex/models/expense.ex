defmodule WiseHomex.Expense do
  @moduledoc """
  Model for an Expense
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to(:fiscal_year, WiseHomex.FiscalYear, type: :binary_id)
    field(:company_name, :string)
    field(:accounting_date, :date)
    field(:total_amount, :integer)
    field(:vat_amount, :integer)
    field(:currency, :string)
    field(:quantity, :integer)
    field(:unit, :string)
    field(:exponent, :integer)

    timestamps(type: :utc_datetime)
  end
end
