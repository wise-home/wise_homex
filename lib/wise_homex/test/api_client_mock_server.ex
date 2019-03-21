defmodule WiseHomex.Test.ApiClientMockServer do
  @moduledoc """
  Mock of the ApiClient used in tests
  """

  use GenServer
  @name __MODULE__

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: @name)
  end

  @doc """
  Set a mock value on the ApiClientMock

  Example call for setting up a mock response for :get_gateways

  ```
  ApiClientMock.set(:get_gateways, %{"include" => "devices"}, {:ok, %WiseHomex.Device{}})
  ```
  """
  def set(api_function, opts, value) do
    GenServer.call(@name, {:push_mock_value, api_function, opts, value})
  end

  @doc """
  Asserts that a given call was made to the mock

  It will return the opts value, so it can be used for asserting using `assert` in `ExUnit`
  If no call was found the return value is false

  Example usage with ExUnit:

  ```
  assert ApiClientMock.called?(:get_gateways) == %{query: %{"include" => "devices}}
  ```
  """
  def called?(api_function) do
    GenServer.call(@name, {:called?, api_function})
  end

  @doc """
  Do a mock api call and receive the set up mock value.
  This will fail if no mock matches the api_function and opts.
  """
  def call_and_get_mock_value(api_function, opts) do
    GenServer.call(@name, {:called!, api_function, opts})
    GenServer.call(@name, {:pop_mock_value, api_function, opts})
  end

  @doc """
  Receive remaining mock calls on the Mock Server.
  Useful for asserting that all calls were made.
  """
  def remaining_calls() do
    GenServer.call(@name, :get_all_mocks)
  end

  @doc """
  Initialize the mock server with an empty request stack
  """
  def init([]) do
    {:ok, initial_state()}
  end

  def initial_state() do
    %{
      calls: %{},
      mocks: %{}
    }
  end

  @doc """
  Push a new mock value to the stack of calls

  - api_function is the key of the function called, e.g. :get_gateways
  - opts is a map with the request attributes, which can include :id, :query, :attrs and :rels,
    but also attributes specific to the api functions, e.g. :gateway_id.
  - value is the value to be returned from the mock

  Note that the calls map will be populated with keys that are tuples of an atom and a map.
  As key order doesn't mapper when comparing maps, this will enable us to set precise mocks.
  """
  def handle_call({:push_mock_value, api_function, opts, value}, _from, state) do
    key = {api_function, opts}

    state =
      update_in(state, [:mocks, key], fn
        nil -> [value]
        list -> [value | list]
      end)

    {:reply, :ok, state}
  end

  @doc """
  Pop a value from the mock
  """
  def handle_call({:pop_mock_value, api_function, opts}, _from, state) do
    key = {api_function, opts}

    {value, state} =
      get_and_update_in(state, [:mocks, key], fn
        nil -> {:no_mock_set, nil}
        [] -> {:no_mock_set, nil}
        [value | rest] -> {value, rest}
      end)

    # Clear out mock keys that refer to an empty list, which means they have been used.
    state =
      Map.update!(state, :mocks, fn
        mocks ->
          Enum.reject(mocks, fn {_k, v} -> v == [] end)
          |> Enum.into(%{})
      end)

    return_value =
      case value do
        :no_mock_set -> {:error, "No mock set on #{api_function} with options #{inspect(opts)}"}
        value -> value
      end

    {:reply, return_value, state}
  end

  @doc """
  Get remaining mock calls
  """
  def handle_call(:get_all_mocks, _from, state) do
    {:reply, Map.fetch!(state, :mocks), state}
  end

  @doc """
  Push a call with opts to the mock
  It will update the calls map with e.g. %{get_gateways: [%{query: %{}}, %{query: %{"include" => "devices"}}, ...]}
  """
  def handle_call({:called!, api_function, opts}, _from, state) do
    state =
      update_in(state, [:calls, api_function], fn
        nil -> [opts]
        list -> [opts | list]
      end)

    {:reply, :ok, state}
  end

  @doc """
  Receive a call from mock including its opts

  First we are receiving the list of opts an api function was called with, then we are searching that list
  for the
  """
  def handle_call({:called?, api_function}, _from, state) do
    {opts, state} =
      get_and_update_in(state, [:calls, api_function], fn
        nil -> {false, nil}
        [] -> {false, nil}
        [opts | rest] -> {opts, rest}
      end)

    {:reply, opts, state}
  end
end
