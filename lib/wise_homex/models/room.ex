defmodule WiseHomex.Room do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    has_many :heat_sources, WiseHomex.HeatSource
    belongs_to :household, WiseHomex.Household
    field :name, :string
  end
end
