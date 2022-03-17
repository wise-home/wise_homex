defmodule WiseHomex.Room do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :household, WiseHomex.Household
    has_many :heat_sources, WiseHomex.HeatSource
    has_many :tap_places, WiseHomex.TapPlace
    field :name, :string
  end
end
