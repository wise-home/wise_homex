defmodule WiseHomex.Household do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to(:tenant, WiseHomex.Account)
    belongs_to(:address, WiseHomex.Address, type: :binary_id)
    has_many(:tenancies, WiseHomex.Tenancy)

    field(:apartment, :string)
    field(:active_from, :date)
    field(:active_to, :date)
    field(:active, :boolean)
  end
end
