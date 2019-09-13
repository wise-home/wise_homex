defmodule WiseHomex.Sim do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    has_one :gateway, WiseHomex.Gateway
    field :icc_id, :string
    field :phone_number, :string
    field :notes, :string
    field :unavailable, :boolean
    field :public_ip, :boolean
    field :provider, :string
    field :inactive, :boolean
  end
end
