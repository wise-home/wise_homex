defmodule WiseHomex.FiscalYear do
  @moduledoc """
  A Fiscal Year
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to(:property, WiseHomex.Property)
    belongs_to(:statement, WiseHomex.Statement)
    has_many(:expenses, WiseHomex.FiscalYear)
    has_many(:account_payments, WiseHomex.AccountPayment)

    field(:utility_type, :string)
    field(:start_date, :date)
    field(:end_date, :date)
  end
end
