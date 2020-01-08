defmodule WiseHomex.WMBusMessageQuery do
  @moduledoc """
  A WMBus Message Query
  """

  use WiseHomex.BaseModel

  embedded_schema do
    embeds_many :devices, WiseHomex.Device
    embeds_many :wmbus_message_infos, WiseHomex.WMBusMessageInfo
    embeds_one :gateway, WiseHomex.Gateway

    field :save, :boolean
    field :timeout, :integer
  end
end
