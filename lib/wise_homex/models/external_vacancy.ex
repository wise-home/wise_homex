defmodule WiseHomex.ExternalVacancy do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :vacancy_info, WiseHomex.VacancyInfo, type: :binary_id
    belongs_to :external_household, WiseHomex.ExternalHousehold, type: :binary_id

    field :system, :string
    field :external_id, :string
    field :number, :integer
    field :synced, :boolean
    field :last_synced_at, :utc_datetime
  end
end
