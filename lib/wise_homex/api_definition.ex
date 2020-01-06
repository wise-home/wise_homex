defmodule WiseHomex.ApiDefinition do
  @moduledoc """
  Converts the API configuration into data that can be used to dynamically create each api endpoint
  """

  defmodule Reader do
    @moduledoc """
    Helper module for reading the API configuration.
    Separating the modules this way allows us to use the function inside a module attribute.
    """

    @typedoc """
    The types of API verbs supported
    """
    @type verb :: :index | :show | :create | :update | :delete

    @typedoc """
    Definition of endpoints for an api resource as given in api_config.exs
    This can be used to create multiple api endpoints as defined below.
    """
    @type resource_definition :: %{
            endpoints: [verb],
            name_plural: String.t(),
            name_singular: String.t(),
            path: String.t(),
            type: String.t()
          }

    @typedoc """
    Definition data for a single api endpoint
    """
    @type api_endpoint :: %{
            verb: verb(),
            name_plural: String.t(),
            name_singular: String.t(),
            path: String.t(),
            type: String.t()
          }

    @doc """
    Read the api configuration from a file, convert it to api resources
    """
    @spec api_endpoints_from_file(filename :: String.t()) :: [api_endpoint]
    def api_endpoints_from_file(filename) do
      {_, variables} = filename |> Code.eval_file()
      variables |> Keyword.fetch!(:endpoints) |> to_api_endpoints()
    end

    @doc """
    Transform the api resource definition into a list of single api endpoints
    """
    @spec to_api_endpoints([resource_definition]) :: [api_endpoint]
    def to_api_endpoints(endpoints) do
      endpoints
      |> Enum.flat_map(fn %{endpoints: endpoints} = resource ->
        endpoints
        |> Enum.map(fn verb ->
          %{
            verb: verb,
            name_singular: resource.name_singular,
            name_plural: resource.name_plural,
            path: resource.path,
            type: resource.type
          }
        end)
      end)
    end
  end

  @external_resource "lib/wise_homex/api_config.exs"
  @api_endpoints "api_config.exs"
                 |> Path.expand("./lib/wise_homex")
                 |> Reader.api_endpoints_from_file()

  @doc """
  The Wise Home API as a list of single functions to be implemented including verbs
  """
  @spec api_endpoints() :: [Reader.api_endpoint()]
  def api_endpoints(), do: @api_endpoints
end
