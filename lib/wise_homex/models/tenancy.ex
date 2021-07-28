defmodule WiseHomex.Tenancy do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    belongs_to :household, WiseHomex.Household
    belongs_to :tenant, WiseHomex.Account
    has_many :account_payments, WiseHomex.AccountPayment
    has_many :direct_expenses, WiseHomex.DirectExpense
    has_many :external_tenancies, WiseHomex.ExternalTenancy

    field :move_in_date, :date
    field :move_out_date, :date
    field :number, :integer
  end

  @doc """
  Helper for getting a sort friendly value for the date fields.
  We use Date.to_erl()/1 which outputs tuples, e.g. {2018, 1, 1} which are easy to use for sorting.
  If date is nil, we treat it as being "since the beginning of the universe", or in our case 1970-01-01.

  iex> sort_date(~D[2018-01-12])
  {2018, 1, 12}

  iex> sort_date("1995-10-15")
  {1995, 10, 15}

  iex> sort_date(nil)
  {1970, 1, 1}
  """
  def sort_date(%Date{} = date) do
    date |> Date.to_erl()
  end

  def sort_date(date) when is_binary(date) do
    date |> Date.from_iso8601!() |> sort_date()
  end

  def sort_date(nil), do: {1970, 1, 1}
end
