defmodule WiseHomex.StatementZip do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    field :zip_content, :string
  end
end
