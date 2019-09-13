defmodule WiseHomex.WMBusDeviceType do
  @moduledoc """
  Type of WMBus meter
  """

  use WiseHomex.BaseModel

  embedded_schema do
    field :name, :string
  end
end
