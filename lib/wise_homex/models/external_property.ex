defmodule WiseHomex.ExternalProperty do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :property, WiseHomex.Property
    has_many :external_households, WiseHomex.ExternalHousehold

    field :system, :string
    field :number, :integer
    field :company_number, :integer
    field :synced, :boolean
    field :last_synced_at, :utc_datetime
    field :sync_method, :string
  end

  @doc """
  The valid enum values of sync_method
  """
  @spec valid_sync_methods() :: [String.t()]
  def valid_sync_methods do
    [
      "none",
      "api",
      "lurtz"
    ]
  end
end
