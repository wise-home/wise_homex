defmodule WiseHomex.TechnicianAccess do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :admin, WiseHomex.Account
    belongs_to :property, WiseHomex.Property
    belongs_to :technician, WiseHomex.Account

    field :start_date, :date
    field :end_date, :date
  end
end
