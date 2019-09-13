defmodule WiseHomex.WMBusManufacturer do
  @moduledoc """
  Manufacturer of a WMBus meter
  """

  use WiseHomex.BaseModel

  embedded_schema do
    field :name, :string
    field :en_61107, :string
  end
end
