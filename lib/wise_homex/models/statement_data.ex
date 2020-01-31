defmodule WiseHomex.StatementData do
  @moduledoc """
  Model for Statement Data import and export
  """

  use WiseHomex.BaseModel

  embedded_schema do
    field :csv, :string
  end
end
