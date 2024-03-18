defmodule WiseHomex.DistributedExpense do
  @moduledoc """
  Module for a Distributed Expense
  """

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :fiscal_year, WiseHomex.FiscalYear, type: :binary_id
    belongs_to :settlement_key, WiseHomex.SettlementKey, type: :binary_id
    field :amount, WiseHomex.QuantityType
    field :business_only, :boolean
    field :expense_type, :string
    field :title, :string
  end

  @doc """
  Supported Distributed Expense types
  """
  def supported_types() do
    [
      "energy_label",
      "distribution_statement",
      "caretaker",
      "snow_removal",
      "cleaning_of_common_areas",
      "graffiti_removal",
      "insurances",
      "guard_and_surveillance",
      "administration",
      "submeters",
      "renovation",
      "electricity",
      "eed_including_online_usage_overview"
    ]
  end
end
