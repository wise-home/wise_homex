defmodule WiseHomex.FiscalYear do
  @moduledoc """
  A Fiscal Year
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to(:statement, WiseHomex.Statement)
    has_many(:expenses, WiseHomex.FiscalYear)
    has_many(:account_payments, WiseHomex.AccountPayment)
    has_many(:vacancy_account_payments, WiseHomex.VacancyAccountPayment)
    embeds_many(:tenancies, WiseHomex.Tenancy)
    embeds_many(:vacancies, WiseHomex.Vacancy)

    field(:utility_type, :string)
    field(:start_date, :date)
    field(:end_date, :date)
  end
end
