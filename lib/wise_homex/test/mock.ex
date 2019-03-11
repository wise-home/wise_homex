defmodule WiseHomex.Test.Mock do
  @moduledoc """
  Mock of the ApiClient used in tests
  """

  use GenServer

  @behaviour WiseHomex.ApiClient.Behaviour
  @name __MODULE__

  def start_link do
    GenServer.start_link(__MODULE__, [], name: @name)
  end

  def get(_config, path, query \\ %{}) do
    GenServer.call(@name, {:called!, :get, path, query})
    GenServer.call(@name, {:pop_mock_value, :get, path, query})
  end

  def post(_config, path, body \\ %{}) do
    GenServer.call(@name, {:called!, :post, path, body})
    GenServer.call(@name, {:pop_mock_value, :post, path, body})
  end

  def post(config, path, query, body) do
    post(config, path |> path_with_query(query), body)
  end

  def patch(_config, path, params) do
    GenServer.call(@name, {:called!, :patch, path, params})
    GenServer.call(@name, {:pop_mock_value, :patch, path, params})
  end

  def delete(_config, path) do
    GenServer.call(@name, {:called!, :delete, path, %{}})
    GenServer.call(@name, {:pop_mock_value, :delete, path, %{}})
  end

  @doc """
  Sets a mock value
  """
  def set(method, path, value, times \\ 1)

  def set(_, _, _, 0) do
    :ok
  end

  def set(method, path, value, times) when times > 0 do
    with :ok <- GenServer.call(@name, {:push_mock_value, method, path, value}) do
      set(method, path, value, times - 1)
    end
  end

  @doc """
  Asserts that a given call was made
  """
  def called?(method, path, payload \\ nil) do
    GenServer.call(@name, {:called?, method, path, payload})
  end

  @doc """
  Asserts that the given endpoint is called
  """
  def assert_called(method, path, payload \\ nil) do
    call = called?(method, path, payload)

    if call == nil || (payload && payload != call) do
      raise "Expected #{method} #{path} (with #{payload |> inspect}). Got:\n#{inspect_calls()}"
    end

    :ok
  end

  @doc """
  Returns a string representation of all calls
  """
  def inspect_calls do
    @name
    |> GenServer.call(:calls)
    |> Enum.flat_map(fn
      {_key, []} ->
        []

      {key, payloads} ->
        payloads
        |> Enum.map(fn payload -> "#{key}: #{payload |> inspect}" end)
    end)
    |> Enum.join("\n")
  end

  @doc """
  Clears the mock state
  """
  def clear do
    GenServer.call(@name, :clear)
  end

  # GenServer Impl

  def init([]) do
    {:ok, init_state()}
  end

  defp init_state do
    %{
      calls: %{},
      mocks: %{}
    }
  end

  def handle_call({:push_mock_value, method, path, value}, _from, state) do
    state =
      update_in(state, [:mocks, "#{method} #{path}"], fn
        nil -> [value]
        list -> [value | list]
      end)

    {:reply, :ok, state}
  end

  def handle_call({:pop_mock_value, method, path, params}, _from, state) do
    {value, state} =
      get_and_update_in(state, [:mocks, "#{method} #{path}"], fn
        nil -> {nil, nil}
        [] -> {nil, nil}
        [value | rest] -> {value, rest}
      end)

    return_value =
      case value do
        nil -> {:error, "No mock set on #{method} #{path}"}
        fun when is_function(fun) -> fun.(params)
        value -> value
      end

    {:reply, return_value, state}
  end

  def handle_call({:called!, method, path, params}, _from, state) do
    state =
      update_in(state, [:calls, "#{method} #{path}"], fn
        nil -> [params]
        list -> [params | list]
      end)

    {:reply, :ok, state}
  end

  def handle_call({:called?, method, path, payload}, _from, state) do
    {params, state} =
      get_and_update_in(state, [:calls, "#{method} #{path}"], fn
        nil ->
          {nil, nil}

        [] ->
          {nil, nil}

        [params | rest] ->
          if payload == nil || params == payload do
            {params, rest}
          else
            {nil, [params | rest]}
          end
      end)

    {:reply, params, state}
  end

  def handle_call(:calls, _from, %{calls: calls} = state) do
    {:reply, calls, state}
  end

  def handle_call(:clear, _from, _state) do
    {:reply, :ok, init_state()}
  end

  # Take a path and append it with an encoded query string
  @spec path_with_query(binary(), map()) :: binary()
  defp path_with_query(path, query) do
    query
    |> URI.encode_query()
    |> case do
      "" -> path
      query_string -> "#{path}?#{query_string}"
    end
  end
end
