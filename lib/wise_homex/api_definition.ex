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
            model: atom(),
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

    @typedoc """
    A map to translate from type to model
    """
    @type type_to_model_map :: %{(type :: String.t()) => model :: atom()}

    @doc """
    Read the api configuration from a file, convert it to api resources
    """
    @spec read_api_config(filename :: String.t()) :: [resource_definition]
    def read_api_config(filename) do
      {_, variables} = filename |> Code.eval_file()
      variables |> Keyword.fetch!(:endpoints)
    end

    @doc """
    Transform the api resource definition into a list of single api endpoints
    """
    @spec to_api_endpoints(resources :: [resource_definition]) :: [api_endpoint]
    def to_api_endpoints(resources) do
      resources
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

    @doc """
    Transform the api resource definition into a map than can be used to map a type to a model.
    This is used in JSONParser to get the correct model struct for a response.
    """
    @spec type_to_model_mappings(resources :: resource_definition) :: type_to_model_map
    def type_to_model_mappings(endpoints) do
      endpoints
      |> Enum.into(%{}, fn %{type: type, model: model} -> {type, model} end)
    end
  end

  @external_resource "lib/wise_homex/api_config.exs"
  @api_config "api_config.exs"
              |> Path.expand("./lib/wise_homex")
              |> Reader.read_api_config()

  @api_endpoints @api_config
                 |> Reader.to_api_endpoints()

  @type_to_model_map @api_config
                     |> Reader.type_to_model_mappings()

  @doc """
  The Wise Home API as a list of single functions to be implemented including verbs
  """
  @spec api_endpoints() :: [Reader.api_endpoint()]
  def api_endpoints(), do: @api_endpoints

  @doc """
  The mappings between models and type as a map
  """
  @spec type_to_model_mappings() :: Reader.type_to_model_map()
  def type_to_model_mappings(), do: @type_to_model_map
end
