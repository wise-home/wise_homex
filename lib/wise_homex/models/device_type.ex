defmodule WiseHomex.DeviceType do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    field :system_name, :string
    field :protocol, :string
    field :power_source, :string
    field :name, :string
    field :manufacturer, :string
    field :kind, :string
  end
end
