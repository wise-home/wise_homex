defmodule WiseHomex.DeviceAuthorization do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to(:device, WiseHomex.Device)
  end
end
