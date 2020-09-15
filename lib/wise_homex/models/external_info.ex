defmodule WiseHomex.ExternalInfo do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    field :company_number, :integer
    field :last_synced_at, :utc_datetime
    field :number, :string
    field :synced, :boolean
    field :system, :string
  end
end
