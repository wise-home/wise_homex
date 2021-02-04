defmodule WiseHomex.VacancyInfo do
  @moduledoc """
  Model used to attach extra information to a vacancy.
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :household, WiseHomex.Household
    belongs_to :external_vacancy, WiseHomex.ExternalVacancy
    has_many :vacancy_account_payments, WiseHomex.VacancyAccountPayment
    has_one :vacancy, WiseHomex.Vacancy

    field :number, :integer
    timestamps type: :utc_datetime
  end
end
