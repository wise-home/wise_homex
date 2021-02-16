defmodule WiseHomex.ExternalResource do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    field :kind, :string
    field :description, :string
    field :signed_url, :string
  end
end
