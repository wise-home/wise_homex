defmodule WiseHomex.Address do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to(:property, WiseHomex.Property)
    has_many(:households, WiseHomex.Household)

    field(:street_and_number, :string)
    field(:zip_code, :string)
    field(:city, :string)
    field(:country_code_alpha3, :string)
  end
end
