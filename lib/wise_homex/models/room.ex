defmodule WiseHomex.Room do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :household, WiseHomex.Household
    field :name, :string
  end
end
