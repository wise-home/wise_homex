defmodule WiseHomex.Radiator do
  @moduledoc """
  A radiator type. Specific radiators placed in a household are HeatSource.
  """

  use WiseHomex.BaseModel

  embedded_schema do
    has_many :heat_sources, WiseHomex.HeatSource

    field :alt_height, :integer
    field :archived_at, :utc_datetime
    field :columns, :integer
    field :depth, :integer
    field :element_length, :integer
    field :group, :string
    field :group_id, :integer
    field :height, :integer
    field :info, :string
    field :illustration_number, :integer
    field :internal_id, :integer
    field :manufacturer, :string
    field :model, :string
    field :performance_per_element, :float
    field :radiator_type, :string
    field :radiator_string, :string
    field :surface_type, :string
  end
end
