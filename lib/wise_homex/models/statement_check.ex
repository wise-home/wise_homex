defmodule WiseHomex.StatementCheck do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :statement, WiseHomex.Statement

    field :system_name, :string
    field :status, :string
    field :status_source, :string
    field :status_updated_at, :utc_datetime
    field :message, :string
  end

  @doc """
  All valid statuses
  """
  @spec valid_statuses() :: [String.t()]
  def valid_statuses do
    [
      "unchecked",
      "checked",
      "error"
    ]
  end
end
