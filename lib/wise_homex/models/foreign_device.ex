defmodule WiseHomex.ForeignDevice do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :household, WiseHomex.Household

    field :start_date, :date
    field :end_date, :date
    field :start_value, WiseHomex.QuantityType
    field :end_value, WiseHomex.QuantityType

    field :meter_type, :string
    field :reading_type, :string
    field :number, :string
  end
end
