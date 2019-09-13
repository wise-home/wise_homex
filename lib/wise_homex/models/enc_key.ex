defmodule WiseHomex.EncKey do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    field :manufacturer, :string
    field :serial, :string
  end
end
