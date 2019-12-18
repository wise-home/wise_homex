defmodule WiseHomex.RadiatorInfo do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    field :pdf_url, :string
  end
end
