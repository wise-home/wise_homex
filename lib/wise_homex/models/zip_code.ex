defmodule WiseHomex.ZipCode do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    field :city, :string
    field :code, :string
  end
end
