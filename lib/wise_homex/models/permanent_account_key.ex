defmodule WiseHomex.PermanentAccountKey do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :account, WiseHomex.Account
    field :name, :string
    field :token, :string
    field :created_at, :utc_datetime
    field :readonly, :boolean
    field :meter_data_provider, :boolean
  end
end
