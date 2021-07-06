defmodule WiseHomex.ReadyInstallation do
  @moduledoc false

  use WiseHomex.BaseModel

  alias WiseHomex.ReadyGroup
  alias WiseHomex.Room

  embedded_schema do
    belongs_to :ready_group, ReadyGroup, type: :binary_id
    belongs_to :room, Room

    field :external_id, :integer
    field :address, :string
    field :city, :string
    field :zip_code, :string
  end
end
