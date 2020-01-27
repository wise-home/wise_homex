defmodule WiseHomex.AccountPayment do
  @moduledoc """
  Model for an account payment
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :tenancy, WiseHomex.Tenancy, type: :binary_id
    belongs_to :fiscal_year, WiseHomex.FiscalYear, type: :binary_id
    field :total_amount, :integer
    field :vat_amount, :integer
    field :currency, :string
    field :accounting_date, :date

    timestamps type: :utc_datetime
  end
end
