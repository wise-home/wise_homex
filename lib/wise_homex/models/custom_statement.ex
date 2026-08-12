defmodule WiseHomex.CustomStatement do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :household, WiseHomex.Household
    belongs_to :tenancy, WiseHomex.Tenancy
    # `join_through` value only lets Ecto compile the association; relations are populated from the JSON:API `included`
    # payload
    many_to_many :statements, WiseHomex.Statement, join_through: "custom_statements_statements_table_name_placeholder"
    belongs_to :approved_by, WiseHomex.User
    belongs_to :declined_by, WiseHomex.User
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
