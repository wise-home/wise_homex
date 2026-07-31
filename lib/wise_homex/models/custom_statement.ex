defmodule WiseHomex.CustomStatement do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :household, WiseHomex.Household
    belongs_to :tenancy, WiseHomex.Tenancy
    # many_to_many because there is no foreign key linking the two here. The
    # join_through name is a placeholder that exists only so Ecto compiles the
    # association — it is never queried and does not refer to any real table; we
    # make no assumptions about the external system's schema.
    many_to_many :statements, WiseHomex.Statement, join_through: "custom_statement_statements"
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
