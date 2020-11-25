defmodule WiseHomex.UnsuccessfulVisit do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :household, WiseHomex.Household
    field :attempt_at, :utc_datetime
    field :billable, :boolean
    field :note, :string
    field :resolved_at, :utc_datetime
  end
end
