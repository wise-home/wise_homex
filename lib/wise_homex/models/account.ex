defmodule WiseHomex.Account do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :owner, __MODULE__
    has_many :account_users, WiseHomex.AccountUser
    has_one :tenancy, WiseHomex.Tenancy, foreign_key: :tenant_id
    has_one :admin_data, WiseHomex.AdminData

    # Administrators can only be set on :admin accounts, and can only be admins
    belongs_to :administrator, WiseHomex.Account

    field :name, :string
    field :role, :string
    field :email, :string
    field :phone, :string
    field :customer_number, :string
    field :postal_address, WiseHomex.PostalAddress

    embeds_one :email_settings, EmailSettings do
      field :ventilation_alarm, :boolean
    end
  end
end
