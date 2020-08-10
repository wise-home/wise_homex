defmodule WiseHomex.VacancyAccountPayment do
  @moduledoc """
  Model for attaching an account payment to a vacancy period.
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :vacancy_info, WiseHomex.VacancyInfo
    belongs_to :fiscal_year, WiseHomex.FiscalYear

    field :total_amount, WiseHomex.QuantityType
    field :vat_amount, WiseHomex.QuantityType
    field :accounting_date, :date
    field :excluded, :boolean

    timestamps type: :utc_datetime
  end
end
