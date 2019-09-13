defmodule WiseHomex.AngelNote do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    field :target_type, :string
    field :target_id, :string
    field :content, :string
    timestamps type: :utc_datetime
  end
end
