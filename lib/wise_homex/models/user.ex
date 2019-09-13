defmodule WiseHomex.User do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    field :name, :string
    field :email, :string
    field :activated_at, :utc_datetime
    field :activation_token, :string
  end
end
