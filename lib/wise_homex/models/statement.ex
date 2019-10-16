defmodule WiseHomex.Statement do
  @moduledoc """
  A Statement represents a distribution statement with possibly many fiscal years each with a utility type
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :property, WiseHomex.Property
    field :start_date, :date
    field :end_date, :date
    field :locked_at, :utc_datetime
  end
end
