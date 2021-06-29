defmodule WiseHomex.ReadyGroup do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    field :external_id, :integer
    field :name, :string
    field :sync, :boolean
  end
end
