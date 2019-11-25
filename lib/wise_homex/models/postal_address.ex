defmodule WiseHomex.PostalAddress do
  @moduledoc """
  Structure that is sent as a map over the API
  """

  use Ecto.Type

  @type t :: %__MODULE__{
          address: String.t(),
          zip_code: String.t(),
          city: String.t(),
          country_code_alpha3: String.t()
        }

  defstruct [
    :address,
    :zip_code,
    :city,
    :country_code_alpha3
  ]

  @doc """
  Builds a new PostalAddress
  """
  @spec new(String.t(), String.t(), String.t(), String.t()) :: t
  def new(address, zip_code, city, country_code_alpha3) do
    %__MODULE__{
      address: address,
      zip_code: zip_code,
      city: city,
      country_code_alpha3: country_code_alpha3
    }
  end

  def cast(%__MODULE__{} = postal_address), do: {:ok, postal_address}

  def cast(%{} = map) do
    map
    |> Enum.into(%{}, fn {key, value} -> {cast_map_key(key), value} end)
    |> case do
      %{address: address, zip_code: zip_code, city: city, country_code_alpha3: country_code_alpha3} ->
        {:ok, new(address, zip_code, city, country_code_alpha3)}

      _ ->
        :error
    end
  end

  def cast(_), do: :error

  # Not really needed, since we only need to cast
  def dump(postal_address), do: {:ok, postal_address}
  def load(data), do: {:ok, data}
  def type, do: :map

  defp cast_map_key(atom) when is_atom(atom), do: atom
  defp cast_map_key(string) when is_binary(string), do: string |> String.replace("-", "_") |> String.to_existing_atom()
  defp cast_map_key(key), do: key
end
