defmodule WiseHomex.DirectExpense do
  @moduledoc """
  Module for a Direct Expense
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :fiscal_year, WiseHomex.FiscalYear, type: :binary_id
    belongs_to :tenancy, WiseHomex.Tenancy, type: :binary_id
    field :total_amount, WiseHomex.QuantityType
    field :expense_type, :string
  end

  @doc """
  Supported Direct Expense types
  """
  def supported_expense_types() do
    [
      "balance_previous_statement"
    ]
  end
end
