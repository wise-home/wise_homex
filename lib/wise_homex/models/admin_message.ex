defmodule WiseHomex.AdminMessage do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :fiscal_year, WiseHomex.FiscalYear
    field :source_system, :string
    field :author_name, :string
    field :author_email, :string
    field :message, :string
    field :additional_info, :map

    timestamps type: :utc_datetime
  end
end
