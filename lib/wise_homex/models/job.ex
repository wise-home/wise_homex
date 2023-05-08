defmodule WiseHomex.Job do
  @moduledoc """
  A Job does a specific task and can be run
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :statement, WiseHomex.Statement

    field :name, :string
    field :state, :string
    field :logs, :string
    field :executed_at, :utc_datetime

    # in microseconds
    field :execution_time, :integer
  end

  @doc """
  All valid statuses
  """
  @spec valid_statuses() :: [String.t()]
  def valid_statuses do
    [
      "none",
      "passed",
      "failed",
      "invalid"
    ]
  end
end
