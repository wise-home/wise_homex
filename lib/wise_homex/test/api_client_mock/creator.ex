defmodule WiseHomex.Test.ApiClientMock.Creator do
  @moduledoc """
  Auto generator for api client mock functions at compile time.
  """

  @doc """
  When used by a module, we inject autogenerated mock functions from the api client definition
  """
  defmacro __using__([]) do
    WiseHomex.ApiDefinition.api_definition()
    |> WiseHomex.ApiDefinition.to_api_resources()
    |> Enum.map(&WiseHomex.Test.ApiClientMock.Creator.create_endpoint/1)
  end

  @doc """
  Create a mock index function
  """
  def create_endpoint({:index, api_resource}) do
    function_name = "get_#{api_resource.name_plural}" |> String.to_atom()

    quote do
      def unquote(function_name)(config, query \\ %{}) do
        WiseHomex.Test.ApiClientMockServer.call_and_get_mock_value(unquote(function_name), %{query: query})
      end
    end
  end

  @doc """
  Create a mock show function
  """
  def create_endpoint({:show, api_resource}) do
    function_name = "get_#{api_resource.name_singular}" |> String.to_atom()

    quote do
      def unquote(function_name)(config, id, query \\ %{}) do
        WiseHomex.Test.ApiClientMockServer.call_and_get_mock_value(unquote(function_name), %{id: id, query: query})
      end
    end
  end

  @doc """
  Create a mock create function
  """
  def create_endpoint({:create, api_resource}) do
    function_name = "create_#{api_resource.name_singular}" |> String.to_atom()

    quote do
      def unquote(function_name)(config, attrs, rels) do
        WiseHomex.Test.ApiClientMockServer.call_and_get_mock_value(unquote(function_name), %{attrs: attrs, rels: rels})
      end
    end
  end

  @doc """
  Create a mock update function
  """
  def create_endpoint({:update, api_resource}) do
    function_name = "update_#{api_resource.name_singular}" |> String.to_atom()

    quote do
      def unquote(function_name)(config, id, attrs, rels \\ %{}) do
        WiseHomex.Test.ApiClientMockServer.call_and_get_mock_value(unquote(function_name), %{
          id: id,
          attrs: attrs,
          rels: rels
        })
      end
    end
  end

  @doc """
  Create a mock delete function
  """
  def create_endpoint({:delete, api_resource}) do
    function_name = "delete_#{api_resource.name_singular}" |> String.to_atom()

    quote do
      def unquote(function_name)(config, id) do
        WiseHomex.Test.ApiClientMockServer.call_and_get_mock_value(unquote(function_name), %{id: id})
      end
    end
  end
end