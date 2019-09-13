defmodule WiseHomex.LatestReport do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :device, WiseHomex.Device
    embeds_many :measurements, WiseHomex.Measurement
  end
end
