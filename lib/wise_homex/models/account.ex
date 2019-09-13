defmodule WiseHomex.Account do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :owner, __MODULE__
    has_many :tenancies, WiseHomex.Tenancy, foreign_key: :tenant_id
    has_many :admin_integrations, WiseHomex.AdminIntegration, foreign_key: :admin_id

    field :name, :string
    field :role, :string
    field :email, :string
    field :phone, :string

    embeds_one :email_settings, EmailSettings do
      field :ventilation_alarm, :boolean
    end
  end
end
