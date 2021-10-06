defmodule WiseHomex.PermanentAccountKey do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    field :name, :string
    field :token, :string
    field :created_at, :utc_datetime
  end
end
