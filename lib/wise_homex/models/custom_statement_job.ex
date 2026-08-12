defmodule WiseHomex.CustomStatementJob do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :requester, WiseHomex.Account
    belongs_to :tenancy, WiseHomex.Tenancy
    belongs_to :custom_statement, WiseHomex.CustomStatement
    # `join_through` value only lets Ecto compile the association; relations are populated from the JSON:API `included`
    # payload
    many_to_many :statements, WiseHomex.Statement,
      join_through: "custom_statement_jobs_statements_table_name_placeholder"

    field :kind, :string
    field :billing_date, :date
    field :tenancy_end_date, :date
    field :inserted_at, :utc_datetime
    field :updated_at, :utc_datetime
  end
end
