defmodule WiseHomex.ReadyGroup do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :ready_customer, WiseHomex.ReadyCustomer, type: :binary_id

    field :external_id, :integer
    field :name, :string
    field :sync, :boolean
  end
end
