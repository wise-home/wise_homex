defmodule WiseHomex.ExternalResource do
  @moduledoc false

  use WiseHomex.BaseModel

  alias WiseHomex.ForeignDevice
  alias WiseHomex.HeatSource
  alias WiseHomex.Device

  embedded_schema do
    belongs_to :heat_source, HeatSource, type: :binary_id
    belongs_to :device, Device, type: :id
    belongs_to :foreign_device, ForeignDevice, type: :binary_id

    field :kind, :string
    field :description, :string
    field :signed_url, :string
  end
end
