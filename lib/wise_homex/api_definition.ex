defmodule WiseHomex.ApiDefinition do
  @moduledoc """
  The definition of the Wise Home API
  """

  defmodule Reader do
    @moduledoc """
    Helper module for reading the API configuration.
    Separating the modules this way allows us to use the function inside a module attribute.
    """

    @typedoc """
    Supported endpoint types
    """
    @type verb :: :index | :show | :create | :update | :delete

    @typedoc """
    Definition of multiple api endpoints as given in automated_api_definition.exs
    """
    @type resource_definition :: %{
            endpoints: [atom],
            name_plural: String.t(),
            name_singular: String.t(),
            path: String.t(),
            type: String.t()
          }

    @typedoc """
    Definition of a single endpoint
    """
    @type single_endpoint :: %{
            name_plural: String.t(),
            name_singular: String.t(),
            path: String.t(),
            type: String.t()
          }

    def api_resources_from_file(filename) do
      # Handle when called directly from Code.eval_file/1, which returns a 2-tuple
      {_, variables} = filename |> Code.eval_file()
      variables |> Keyword.fetch!(:endpoints) |> to_api_resources()
    end

    @doc """
    Transform the api resource definition into a list of single api functions
    """
    @spec to_api_resources([resource_definition]) :: [{verb, single_endpoint}]
    def to_api_resources(endpoints) do
      endpoints
      |> Enum.flat_map(fn %{endpoints: endpoints} = resource ->
        endpoints
        |> Enum.map(fn verb ->
          api_resource = %{
            name_singular: resource.name_singular,
            name_plural: resource.name_plural,
            path: resource.path,
            type: resource.type
          }

          {verb, api_resource}
        end)
      end)
    end
  end

  @external_resource "lib/wise_homex/api_config.exs"
  @api_resources "api_config.exs"
                 |> Path.expand("./lib/wise_homex")
                 |> Reader.api_resources_from_file()

  @doc """
  The Wise Home API as a list of single functions to be implemented including verbs
  """
  @spec api_resources() :: [{Reader.verb(), Reader.single_endpoint()}]
  def api_resources(), do: @api_resources
end
