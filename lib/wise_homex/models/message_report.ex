defmodule WiseHomex.MessageReport do
  @moduledoc """
  A report from a message conversation with gateway or device
  """

  use WiseHomex.BaseModel

  embedded_schema do
    field :name, :string
    field :started_at, :string
    field :stopped_at, :string
    field :events, {:array, :string}
  end
end
