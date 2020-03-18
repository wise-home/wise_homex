defmodule WiseHomex.Statement do
  @moduledoc """
  A Statement represents a distribution statement with possibly many fiscal years each with a utility type
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :property, WiseHomex.Property
    has_many :fiscal_years, WiseHomex.FiscalYear

    field :start_date, :date
    field :end_date, :date
    field :done_at, :utc_datetime
    field :locked_at, :utc_datetime
  end
end
