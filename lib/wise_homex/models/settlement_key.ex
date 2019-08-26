defmodule WiseHomex.SettlementKey do
  @moduledoc """
  SettlementKey which is the base for SettlementValues. A SettlementKey can exist in three different scopes: Globally,
  on admin level and on property level.
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to(:admin, WiseHomex.Account)
    belongs_to(:property, WiseHomex.Property)
    field(:name, :string)
    field(:unit, :string)
  end
end
