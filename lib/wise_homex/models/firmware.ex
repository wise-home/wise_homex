defmodule WiseHomex.Firmware do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    field(:manufacturer_code, :string)
    field(:image_type, :string)
    field(:file_version, :string)

    timestamps()
  end
end
