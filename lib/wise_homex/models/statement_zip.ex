defmodule WiseHomex.StatementZip do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    field :zip_content, :string
    field :zip_file_name, :string
  end
end
