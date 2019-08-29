defmodule WiseHomex.SettlementValue do
  @moduledoc """
  An instance of a SettlementKey.
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :settlement_key, WiseHomex.SettlementKey
    belongs_to :household, WiseHomex.Household
    field :value, :float
    field :active_from, :date
    field :active_to, :date
  end
end
