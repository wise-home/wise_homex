defmodule WiseHomex.ExternalResource do
  @moduledoc false

  use WiseHomex.BaseModel

  alias WiseHomex.HeatSource

  embedded_schema do
    belongs_to :heat_source, HeatSource, type: :binary_id

    field :kind, :string
    field :description, :string
    field :signed_url, :string
  end
end
