defmodule WiseHomex.Property do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :admin, WiseHomex.Account
    has_many :addresses, WiseHomex.Address
    has_many :external_properties, WiseHomex.ExternalProperty
    has_many :statements, WiseHomex.Statement
    has_one :statement_config, WiseHomex.StatementConfig

    belongs_to :snapshot_of, __MODULE__
    has_one :snapshot, __MODULE__, foreign_key: :snapshot_of_id

    field :active_from, :date
    field :active_to, :date
    field :name, :string
    field :legal_name, :string
    field :number, :integer
    field :postal_address, WiseHomex.PostalAddress
    field :published, :boolean
    field :central_heating_system_kind, :string
    field :radiator_meter_installation_spot, :string
  end

  def central_heating_system_kinds do
    ["none", "single_pipe", "double_pipe"]
  end

  def radiator_meter_installation_spots do
    ["none", "quarter", "third"]
  end
end
