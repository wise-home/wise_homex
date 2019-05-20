defmodule WiseHomex.AdminIntegration do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to(:admin, WiseHomex.Account)

    field(:integration_type, :string)
    field(:config, :map)
  end
end
