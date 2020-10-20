defmodule WiseHomex.Test.ApiClientMock.Creator do
  @moduledoc """
  Auto generator for api client mock functions at compile time.
  """

  @doc """
  When used by a module, we inject autogenerated mock functions from the api client definition
  """
  defmacro __using__([]) do
    WiseHomex.ApiDefinition.api_endpoints()
    |> Enum.map(&WiseHomex.Test.ApiClientMock.Creator.create_endpoint/1)
  end

  @doc """
  Functions for creating endpoints at compile time
  """
  # Create a mock index function
  def create_endpoint(%{verb: :index} = api_endpoint) do
    function_name = "get_#{api_endpoint.name_plural}" |> String.to_atom()

    quote do
      def unquote(function_name)(config, query) do
        WiseHomex.Test.ApiClientMockServer.call_and_get_mock_value(unquote(function_name), %{query: query})
      end
    end
  end

  # Create a mock show function
  def create_endpoint(%{verb: :show} = api_endpoint) do
    function_name = "get_#{api_endpoint.name_singular}" |> String.to_atom()

    quote do
      def unquote(function_name)(config, id, query) do
        WiseHomex.Test.ApiClientMockServer.call_and_get_mock_value(unquote(function_name), %{id: id, query: query})
      end
    end
  end

  # Create a mock create function
  def create_endpoint(%{verb: :create} = api_endpoint) do
    function_name = "create_#{api_endpoint.name_singular}" |> String.to_atom()

    quote do
      def unquote(function_name)(config, attrs, rels, query) do
        args =
          [attrs: attrs, rels: rels, query: query]
          |> Enum.reject(fn {_key, value} -> value == %{} end)
          |> Enum.into(%{})

        WiseHomex.Test.ApiClientMockServer.call_and_get_mock_value(unquote(function_name), args)
      end
    end
  end

  # Create a mock update function
  def create_endpoint(%{verb: :update} = api_endpoint) do
    function_name = "update_#{api_endpoint.name_singular}" |> String.to_atom()

    quote do
      def unquote(function_name)(config, id, attrs, rels, query) do
        args =
          [id: id, attrs: attrs, rels: rels, query: query]
          |> Enum.reject(fn {_key, value} -> value == %{} end)
          |> Enum.into(%{})

        WiseHomex.Test.ApiClientMockServer.call_and_get_mock_value(unquote(function_name), args)
      end
    end
  end

  # Create a mock delete function
  def create_endpoint(%{verb: :delete} = api_endpoint) do
    function_name = "delete_#{api_endpoint.name_singular}" |> String.to_atom()

    quote do
      def unquote(function_name)(config, id) do
        WiseHomex.Test.ApiClientMockServer.call_and_get_mock_value(unquote(function_name), %{id: id})
      end
    end
  end
end
