defmodule WiseHomex.FiscalYear do
  @moduledoc """
  A Fiscal Year
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to(:property, WiseHomex.Property)
    belongs_to(:statement, WiseHomex.Statement)

    field(:utility_type, :string)
    field(:start_date, :date)
    field(:end_date, :date)
  end
end

