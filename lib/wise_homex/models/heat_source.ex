defmodule WiseHomex.HeatSource do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :room, WiseHomex.Room
    belongs_to :radiator, WiseHomex.Radiator
    has_many :devices, WiseHomex.Device
    has_many :external_resources, WiseHomex.ExternalResource
    embeds_one :unknown_radiator, WiseHomex.UnknownRadiator

    field :floor_area, WiseHomex.QuantityType
    field :length, :integer
    field :remote, :boolean
    field :source_type, :string
    field :radiator_string, :string
    field :active_from, :date
    field :active_to, :date
    field :needs_review, :boolean
  end
end
