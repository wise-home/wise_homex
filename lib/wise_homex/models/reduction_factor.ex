defmodule WiseHomex.ReductionFactor do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :room, WiseHomex.Room

    field :calculation_method, :string
    field :value, :decimal

    field :active_from, :date
    field :active_to, :date
  end
end
