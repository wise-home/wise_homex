defmodule WiseHomex.AccountPaymentImporterFile do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    field :fiscal_year_id, :string
    field :file_content, :string
    field :external_system, :string
  end
end
