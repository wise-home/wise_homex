defmodule WiseHomex.ThermalInfo do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :room, WiseHomex.Room

    # Floor Reduction
    field :building_has_above_three_heated_floors, :boolean
    field :floor_position_in_building, :string

    # Corner Reduction
    field :has_external_walls_corner, :boolean
    field :external_walls_corner_shortest_wall_length, :string
    field :external_walls_corner_wall_to_north_or_east, :boolean

    # Extra Reduction
    field :position_in_relation_to_gate, :string
  end
end
