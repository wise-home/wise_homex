defmodule WiseHomex.HeatSource do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :room, WiseHomex.Room
    belongs_to :radiator, WiseHomex.Radiator

    field :floor_area, WiseHomex.QuantityType
    field :length, :integer
    field :remote, :boolean
    field :source_type, :string
    field :radiator_string, :string
  end
end
