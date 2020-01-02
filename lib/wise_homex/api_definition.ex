defmodule WiseHomex.ApiDefinition do
  @moduledoc """
  The definition of the Wise Home API
  """

  defmodule APIResource do
    @moduledoc """
    A definition of an api resource
    """

    @type t :: %__MODULE__{
            name_singular: String.t(),
            name_plural: String.t(),
            path: String.t(),
            type: String.t()
          }

    defstruct [:name_singular, :name_plural, :path, :type]
  end

  @type endpoint_name :: atom()

  @type endpoint_definition :: %{endpoints: [atom], path: String.t(), type: String.t()}

  @type api_definition :: %{endpoint_name => endpoint_definition}

  @doc """
  The Wise Home API as a list of ApiResource structs
  """
  @spec api_resources() :: [APIResource.t()]
  def api_resources() do
    api_definition() |> to_api_resources()
  end

  # The definition of the Wise Home API
  defp api_definition() do
    %{
      expense: %{
        endpoints: [:index, :show, :create, :update, :delete],
        path: "/expenses",
        type: "expenses"
      }
    }
  end

  # Transforms the api definition into an APIResource struct representing every function that should be created
  defp to_api_resources(api_definition) do
    api_definition
    |> Enum.flat_map(fn {resource_name, %{endpoints: endpoints, path: path, type: type}} ->
      endpoints
      |> Enum.map(fn verb ->
        api_resource = %APIResource{
          name_singular: resource_name |> Atom.to_string(),
          name_plural: type |> snake_case(),
          path: path,
          type: type
        }

        {verb, api_resource}
      end)
    end)
  end

  @doc """
  Transform a kebab cased string to snake case

  iex> ApiDefinition.snake_case("large-households")
  "large_households"

  iex> ApiDefinition.snake_case("households")
  "households"

  iex> ApiDefinition.snake_case("")
  ""
  """
  def snake_case(input), do: input |> String.replace("-", "_")
end
