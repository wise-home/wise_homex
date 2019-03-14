defmodule WiseHomex.Property do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to(:admin, WiseHomex.Account)
    field(:name, :string)
    has_many(:addresses, WiseHomex.Address)
  end
end
