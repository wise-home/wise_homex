defmodule WiseHomex.QuantityType do
  @moduledoc """
  An Ecto type for Quantity
  """

  use Ecto.Type

  @impl Ecto.Type
  def type, do: :string

  @impl Ecto.Type
  def cast(value) when is_binary(value), do: Quantity.parse(value)
  def cast(%Quantity{} = value), do: {:ok, value}
  def cast(nil), do: nil
  def cast(_), do: :error

  @impl Ecto.Type
  def load(value) when is_binary(value), do: Quantity.parse(value)
  def load(nil), do: nil
  def load(_), do: :error

  @impl Ecto.Type
  def dump(%Quantity{} = value), do: {:ok, Quantity.to_string(value)}
  def dump(_), do: :error
end
