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

  def cast(%{address: address, zip_code: zip_code, city: city, country_code_alpha3: country_code_alpha3}) do
    {:ok, new(address, zip_code, city, country_code_alpha3)}
  end

  def cast(%{
        "address" => address,
        "zip_code" => zip_code,
        "city" => city,
        "country_code_alpha3" => country_code_alpha3
      }) do
    {:ok, new(address, zip_code, city, country_code_alpha3)}
  end

  def cast(_), do: :error

  # Not really needed, since we only need to cast
  def dump(postal_address), do: {:ok, postal_address}
  def load(data), do: {:ok, data}
  def type, do: :map
end
