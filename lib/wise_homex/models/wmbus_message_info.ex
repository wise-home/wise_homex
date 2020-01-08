defmodule WiseHomex.WMBusMessageInfo do
  @moduledoc """
  A WMBus Message Info
  """

  use WiseHomex.BaseModel

  embedded_schema do
    embeds_one :device, WiseHomex.Device

    field :signal_strength, :integer
    field :time, :utc_datetime
  end
end
