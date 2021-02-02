defmodule WiseHomex.Vacancy do
  @moduledoc """
  A vacancy period between, before or after registered tenancies.
  The number is the same as the tenancy just before this vacancy. If no vacancies comes before, the number is 0.
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :household, WiseHomex.Household
    belongs_to :vacancy_info, WiseHomex.VacancyInfo
    has_many :external_vacancies, WiseHomex.ExternalVacancy

    field :number, :integer
    field :start_date, :date
    field :end_date, :date
  end
end
