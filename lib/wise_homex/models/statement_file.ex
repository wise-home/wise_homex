defmodule WiseHomex.StatementFile do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :statement, WiseHomex.Statement
    belongs_to :external_resource, WiseHomex.ExternalResource

    field :version, :integer
    field :approval_date, :date
  end
end
