defmodule WiseHomex.Creator do
  @moduledoc """
  Auto creation of main wise_homex module functions from configuration

  These function simply delegate to the api_client() function, which in turn sends a request to either
  the API client implementation or the mock server
  """

  @doc """
  When used by a module, we inject autogenerated mock functions from the api client definition
  """
  defmacro __using__([]) do
    WiseHomex.ApiDefinition.api_endpoints()
    |> Enum.map(&WiseHomex.Creator.create_endpoint/1)
  end

  @doc """
  Create an index function that delegates to api_client()
  """
  def create_endpoint(%{verb: :index} = api_endpoint) do
    function_name = "get_#{api_endpoint.name_plural}" |> String.to_atom()

    quote do
      def unquote(function_name)(config, query \\ %{}), do: api_client().unquote(function_name)(config, query)
    end
  end

  @doc """
  Create a show function that delegates to api_client()
  """
  def create_endpoint(%{verb: :show} = api_endpoint) do
    function_name = "get_#{api_endpoint.name_singular}" |> String.to_atom()

    quote do
      def unquote(function_name)(config, id, query \\ %{}), do: api_client().unquote(function_name)(config, id, query)
    end
  end

  @doc """
  Create a create function that delegates to api_client()
  """
  def create_endpoint(%{verb: :create} = api_endpoint) do
    function_name = "create_#{api_endpoint.name_singular}" |> String.to_atom()

    quote do
      def unquote(function_name)(config, attrs, rels \\ %{}, query \\ %{}),
        do: api_client().unquote(function_name)(config, attrs, rels, query)
    end
  end

  @doc """
  Create an update function that delegates to api_client()
  """
  def create_endpoint(%{verb: :update} = api_endpoint) do
    function_name = "update_#{api_endpoint.name_singular}" |> String.to_atom()

    quote do
      def unquote(function_name)(config, id, attrs, rels \\ %{}, query \\ %{}),
        do: api_client().unquote(function_name)(config, id, attrs, rels, query)
    end
  end

  @doc """
  Create a delete function that delegates to api_client()
  """
  def create_endpoint(%{verb: :delete} = api_endpoint) do
    function_name = "delete_#{api_endpoint.name_singular}" |> String.to_atom()

    quote do
      def unquote(function_name)(config, id), do: api_client().unquote(function_name)(config, id)
    end
  end
end
