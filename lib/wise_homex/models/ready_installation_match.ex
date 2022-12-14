defmodule WiseHomex.ReadyInstallationMatch do
  @moduledoc false

  use WiseHomex.BaseModel

  alias WiseHomex.Household
  alias WiseHomex.ReadyInstallation

  embedded_schema do
    belongs_to :household, Household
    belongs_to :ready_installation, ReadyInstallation, type: :binary_id

    field :distance, :integer
    field :ready_installation_count, :integer
  end
end
