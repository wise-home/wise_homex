defmodule WiseHomex.ConfigurableMeters do
  @moduledoc """
  Cached information about unconfigured meters
  """

  use WiseHomex.BaseModel

  embedded_schema do
    field :updated_at, :utc_datetime
    embeds_many :meters, WiseHomex.ConfigurableMeterID
  end
end
