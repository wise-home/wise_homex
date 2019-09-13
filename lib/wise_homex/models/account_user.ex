defmodule WiseHomex.AccountUser do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :account, WiseHomex.Account
    belongs_to :user, WiseHomex.User
    field :api_key, :string
  end
end
