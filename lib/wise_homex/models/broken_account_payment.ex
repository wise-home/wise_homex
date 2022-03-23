defmodule WiseHomex.BrokenAccountPayment do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :household, WiseHomex.Household

    field :accounting_date, :date
    field :total_amount, WiseHomex.QuantityType
    field :vat_amount, WiseHomex.QuantityType
    field :period_from, :date
    field :period_to, :date
    field :utility_type, :string
    field :external_system, :string
    field :external_id, :string
  end
end
