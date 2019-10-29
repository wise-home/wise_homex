defmodule WiseHomex.Radiator do
  @moduledoc """
  A radiator type. Specific radiators placed in a household are HeatSource.
  """

  use WiseHomex.BaseModel

  embedded_schema do
    has_many :heat_sources, WiseHomex.HeatSource

    field :internal_id, :integer
    field :group, :string
    field :group_id, :integer
    field :manufacturer, :string
    field :model, :string
    field :illustration_number, :integer
    field :surface_type, :string
    field :radiator_type, :string
    field :columns, :integer
    field :depth, :integer
    field :height, :integer
    field :alt_height, :integer
    field :element_length, :integer
    field :performance_per_element, :float
  end
end
