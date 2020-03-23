defmodule WiseHomex.Property do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :admin, WiseHomex.Account
    belongs_to :external_info, WiseHomex.ExternalInfo
    has_many :addresses, WiseHomex.Address
    has_many :statements, WiseHomex.Statement
    has_many :fiscal_years, WiseHomex.FiscalYear
    has_one :statement_config, WiseHomex.StatementConfig

    field :name, :string
    field :legal_name, :string
    field :number, :integer
    field :postal_address, WiseHomex.PostalAddress
  end
end
