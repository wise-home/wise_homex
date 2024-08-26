defmodule WiseHomex.UnknownRadiator do
  @moduledoc false

  use WiseHomex.BaseModel

  @primary_key false

  embedded_schema do
    field :group_id, :integer
    field :depth_mm, :integer
    field :height_mm, :integer
    field :alt_height_mm, :integer
    field :element_length_mm, :integer
  end
end
