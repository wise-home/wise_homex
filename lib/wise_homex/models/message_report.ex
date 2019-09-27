defmodule WiseHomex.MessageReport do
  @moduledoc """
  A report from a message conversation with gateway or device
  """

  use WiseHomex.BaseModel

  embedded_schema do
    field :name, :string
    field :started_at, :utc_datetime
    field :stopped_at, :utc_datetime
    embeds_many :events, WiseHomex.MessageReport.Event
  end
end
