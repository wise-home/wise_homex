defmodule WiseHomex.ExternalHousehold do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :household, WiseHomex.Household
    belongs_to :external_property, WiseHomex.ExternalProperty, type: :binary_id
    has_many :external_tenancies, WiseHomex.ExternalTenancy
    has_many :external_vacancies, WiseHomex.ExternalVacancy

    field :system, Ecto.Enum, values: WiseHomex.ExternalSystem.values()
    field :number, :integer
    field :synced, :boolean
    field :last_synced_at, :utc_datetime
  end
end
