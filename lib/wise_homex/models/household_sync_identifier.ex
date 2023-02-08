defmodule WiseHomex.HouseholdSyncIdentifier do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :household, WiseHomex.Household
    field :system, :string
    field :household_number, :string
  end
end
