defmodule WiseHomex.FiscalYear do
  @moduledoc """
  A Fiscal Year
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :statement, WiseHomex.Statement
    embeds_many :tenancies, WiseHomex.Tenancy
    embeds_many :vacancies, WiseHomex.Vacancy
    has_many :account_payments, WiseHomex.AccountPayment
    has_many :direct_expenses, WiseHomex.DirectExpense
    has_many :distributed_expenses, WiseHomex.DistributedExpense
    has_many :expenses, WiseHomex.Expense
    has_many :fuel_check_points, WiseHomex.FuelCheckPoint
    has_many :vacancy_account_payments, WiseHomex.VacancyAccountPayment
    has_many :admin_messages, WiseHomex.AdminMessage

    field :locked_at, :utc_datetime
    field :utility_type, :string
    field :start_date, :date
    field :end_date, :date
  end
end
