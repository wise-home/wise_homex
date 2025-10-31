defmodule WiseHomex.FlexStatement do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    field :filename, :string
    field :pdf_content, :string
  end
end
