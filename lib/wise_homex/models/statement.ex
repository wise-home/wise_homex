defmodule WiseHomex.Statement do
  @moduledoc """
  A Statement represents a distribution statement with possibly many fiscal years each with a utility type
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :property, WiseHomex.Property
    has_many :fiscal_years, WiseHomex.FiscalYear
    has_many :statement_files, WiseHomex.StatementFile
    has_one :statement_config, WiseHomex.StatementConfig

    field :start_date, :date
    field :end_date, :date
    field :done_at, :utc_datetime
    field :initially_locked_at, :utc_datetime
    field :locked_at, :utc_datetime
    field :skip_moving_fee, :boolean
  end
end
