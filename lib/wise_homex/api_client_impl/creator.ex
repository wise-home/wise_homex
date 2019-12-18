defmodule WiseHomex.ApiClientImpl.Creator do
  @moduledoc """
  Module for functions to autogenerate api functions. These are collected
  in a common module to ensure that they are available when we need them at compile time.
  """

  # Create all endpoints defined in the api configuration during compilation
  defmacro __using__([]) do
    WiseHomex.ApiDefinition.api_definition()
    |> WiseHomex.ApiDefinition.to_api_resources()
    |> Enum.map(&WiseHomex.ApiClientImpl.Creator.create_endpoint/1)
  end

  @doc """
  Create an index endpoint
  """
  def create_endpoint({:index, api_resource}) do
    function_name = "get_#{api_resource.name_plural}" |> String.to_atom()

    quote do
      def unquote(function_name)(config, query \\ %{}) do
        WiseHomex.Request.get(config, unquote(api_resource.path), query)
      end
    end
  end

  @doc """
  Create a show endpoint
  """
  def create_endpoint({:show, api_resource}) do
    function_name = "get_#{api_resource.name_singular}" |> String.to_atom()

    quote do
      def unquote(function_name)(config, id, query \\ %{}) do
        id = "#{unquote(api_resource.path)}/#{id}"
        WiseHomex.Request.get(config, id, query)
      end
    end
  end

  @doc """
  Create a create endpoint
  """
  def create_endpoint({:create, api_resource}) do
    function_name = "create_#{api_resource.name_singular}" |> String.to_atom()

    quote do
      def unquote(function_name)(config, attrs, rels) do
        payload =
          %{
            data: %{
              type: unquote(api_resource.type),
              attributes: attrs,
              relationships: rels
            }
          }
          |> normalize_payload()

        WiseHomex.Request.post(config, unquote(api_resource.path), payload)
      end
    end
  end

  @doc """
  Create an update endpoint
  """
  def create_endpoint({:update, api_resource}) do
    function_name = "update_#{api_resource.name_singular}" |> String.to_atom()

    quote do
      def unquote(function_name)(config, id, attrs, rels \\ %{}) do
        payload =
          %{
            data: %{
              type: unquote(api_resource.type),
              id: id,
              attributes: attrs,
              relationships: rels
            }
          }
          |> normalize_payload()

        path = "#{unquote(api_resource.path)}/#{id}"
        WiseHomex.Request.patch(config, path, payload)
      end
    end
  end

  @doc """
  Create a delete endpoint
  """
  def create_endpoint({:delete, api_resource}) do
    function_name = "delete_#{api_resource.name_singular}" |> String.to_atom()

    quote do
      def unquote(function_name)(config, id) do
        path = "#{unquote(api_resource.path)}/#{id}"
        WiseHomex.Request.delete(config, path)
      end
    end
  end
end
