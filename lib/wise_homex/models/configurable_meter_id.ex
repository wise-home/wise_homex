defmodule WiseHomex.ConfigurableMeterID do
  @moduledoc """
  The combined ID for a WMBus meter
  """

  use WiseHomex.BaseModel

  embedded_schema do
    field(:serial, :string)
    field(:version, :integer)
    field(:configurable, :boolean)
    embeds_one(:manufacturer, WiseHomex.WMBusManufacturer)
    embeds_one(:device_type, WiseHomex.WMBusDeviceType)
  end
end
