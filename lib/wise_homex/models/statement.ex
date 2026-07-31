defmodule WiseHomex.Statement do
  @moduledoc """
  A Statement represents a distribution statement with possibly many fiscal years each with a utility type
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :property, WiseHomex.Property
    has_many :fiscal_years, WiseHomex.FiscalYear
    has_many :jobs, WiseHomex.Job
    has_many :statement_files, WiseHomex.StatementFile
    has_one :statement_config, WiseHomex.StatementConfig
    # many_to_many because there is no foreign key linking the two here. The
    # join_through name is a placeholder that exists only so Ecto compiles the
    # association — it is never queried and does not refer to any real table; we
    # make no assumptions about the external system's schema.
    many_to_many :custom_statements, WiseHomex.CustomStatement, join_through: "custom_statement_statements"

    field :start_date, :date
    field :end_date, :date
    field :done_at, :utc_datetime
    field :initially_locked_at, :utc_datetime
    field :locked_at, :utc_datetime
    field :archived_at, :utc_datetime
    field :cancelled_at, :utc_datetime
    field :skip_moving_fee, :boolean
    field :deadline, :date
  end
end
