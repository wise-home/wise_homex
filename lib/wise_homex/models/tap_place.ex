defmodule WiseHomex.TapPlace do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :room, WiseHomex.Room

    field :tap_type, :string
    field :hot_water, :boolean, default: false
    field :cold_water, :boolean, default: false
    field :active_from, :date
    field :active_to, :date
    field :tap_shares, :integer
    field :danish, :string
  end

  def tap_type_kinds do
    [
      "kitchen_sink",
      "sink",
      "shower",
      "bathtub",
      "spa",
      "bidet",
      "tap",
      "hairdresser_tap",
      "large_sink",
      "dish_washer",
      "washing_machine",
      "outdoor_kitchen",
      "toilet"
    ]
  end
end
