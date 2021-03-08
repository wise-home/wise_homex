defmodule WiseHomex.FuelCheckPoint do
  @moduledoc """
  A fuel check point represents how much there is left of a fuel type.
  For example, imagine that you have bought heating oil three times during the year: 
  20 L for 100 DKK, 20 L for 200 DKK and 20 L for 400 DKK (in order of accounting date).
  At the end of the fiscal year you have 30 L remaining.
  Now you can create a Fuel Check Point to indicate this fact; 30 L of heating oil remaining.
  Wise Home will automatically calculate the cost of the remaining fuel.
  In our example, the cost of the remaining heating oil is valued to 500 DKK (0/20 * 100 DKK + 10/20 * 200 DKK + 20/20 * 400).
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :fiscal_year, WiseHomex.FiscalYear, type: :binary_id
    field :fuel_type, :string
    field :remaining, WiseHomex.QuantityType
    field :cost, WiseHomex.QuantityType
  end
end
