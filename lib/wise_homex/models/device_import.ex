defmodule WiseHomex.DeviceImport do
  @moduledoc """
  Result from a device import
  """

  use WiseHomex.BaseModel

  embedded_schema do
    field :dry_run, :boolean
    field :result_markdown, :string
  end
end
