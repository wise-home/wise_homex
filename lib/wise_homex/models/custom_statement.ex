defmodule WiseHomex.CustomStatement do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :tenancy, WiseHomex.Tenancy
    has_one :pdf, WiseHomex.ExternalResource

    field :kind, :string
    field :start_date, :date
    field :end_date, :date
    field :tenant_name, :string
    field :approved_at, :utc_datetime
    field :declined_at, :utc_datetime
    field :inserted_at, :utc_datetime
  end
end
