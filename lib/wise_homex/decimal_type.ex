defmodule WiseHomex.DecimalType do
  @moduledoc """
  An Ecto type for Decimal. Saves the decimal as a string
  """

  use Ecto.Type

  @impl Ecto.Type
  def type, do: :string

  @impl Ecto.Type
  def cast(value) when is_binary(value), do: Decimal.parse(value)
  def cast(%Decimal{} = value), do: {:ok, value}
  def cast(nil), do: {:ok, nil}
  def cast(_), do: :error

  @impl Ecto.Type
  def load(value) when is_binary(value), do: Decimal.parse(value)
  def load(nil), do: {:ok, nil}
  def load(_), do: :error

  @impl Ecto.Type
  def dump(%Decimal{} = value) do
    string_value =
      if value.exp > 0 do
        Decimal.to_string(value, :raw)
      else
        Decimal.to_string(value, :normal)
      end

    {:ok, string_value}
  end

  def dump(_), do: :error
end
