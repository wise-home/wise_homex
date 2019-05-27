defmodule WiseHomex.ExternalInfo do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    field(:system, :string)
    field(:number, :string)
    field(:synced, :boolean)
  end
end