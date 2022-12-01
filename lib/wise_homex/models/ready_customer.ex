defmodule WiseHomex.ReadyCustomer do
  @moduledoc false

  use WiseHomex.BaseModel

  alias WiseHomex.ReadyGroup

  embedded_schema do
    belongs_to :admin, WiseHomex.Account
    has_many :ready_groups, ReadyGroup
  end
end
