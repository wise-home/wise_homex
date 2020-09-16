defmodule WiseHomex.AdminData do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :account, WiseHomex.Account

    field :require_customer_number, :boolean
  end
end
