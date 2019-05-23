defmodule ApiClientMockServerTest do
  use ExUnit.Case

  alias WiseHomex.Test.ApiClientMockServer, as: MockServer

  setup do
    MockServer.start_link()

    :ok
  end

  test "it sets and receives a mock value" do
    opts = %{params: [1, 2, 3, 4], query: %{"hej" => "med_dig"}}

    MockServer.set(
      :some_function,
      opts,
      {:ok, 1234}
    )

    MockServer.call_and_get_mock_value(:some_function, opts)
    assert MockServer.called?(:some_function) == opts
  end

  test "it sets and receives two different mock values" do
    opts = %{params: [1, 2, 3, 4], query: %{"hej" => "med_dig"}}

    MockServer.set(
      :some_function,
      opts,
      {:ok, 1234}
    )

    MockServer.set(
      :other_function,
      %{},
      {:ok, 1234}
    )

    MockServer.call_and_get_mock_value(:some_function, opts)
    MockServer.call_and_get_mock_value(:other_function, %{})

    assert MockServer.called?(:some_function) == opts
    assert MockServer.called?(:other_function) == %{}
  end

  test "it sets and receives three similar mock values" do
    opts = %{params: [1, 2, 3, 4], query: %{"hej" => "med_dig"}}

    MockServer.set(
      :some_function,
      opts,
      {:ok, 1234},
      3
    )

    MockServer.call_and_get_mock_value(:some_function, opts)
    MockServer.call_and_get_mock_value(:some_function, opts)
    MockServer.call_and_get_mock_value(:some_function, opts)

    assert MockServer.called?(:some_function) == opts
    assert MockServer.called?(:some_function) == opts
    assert MockServer.called?(:some_function) == opts

    assert MockServer.remaining_calls() == %{}
  end

  test "it returns false if a call was not made" do
    MockServer.set(
      :other_function,
      %{},
      {:ok, 1234}
    )

    assert MockServer.called?(:some_function) == false
  end

  test "it returns an error getting a value for a non existing mock" do
    MockServer.set(
      :other_function,
      %{},
      {:ok, 1234}
    )

    assert MockServer.call_and_get_mock_value(:non_existing, %{hej: true}) ==
             {:error, "No mock set for call", :non_existing, %{hej: true}}
  end

  test "it leaves state untouched when getting a value for a non existing mock" do
    MockServer.set(
      :other_function,
      %{},
      {:ok, 1234}
    )

    assert MockServer.call_and_get_mock_value(:non_existing, %{hej: true}) ==
             {:error, "No mock set for call", :non_existing, %{hej: true}}

    assert MockServer.remaining_calls() == %{{:other_function, %{}} => [ok: 1234]}
  end

  test "it returns an error getting a value for a non existing mock where only opts differ" do
    MockServer.set(
      :other_function,
      %{"include" => "french_fries"},
      {:ok, 1234}
    )

    assert MockServer.call_and_get_mock_value(:other_function, %{}) ==
             {:error, "No mock set for call", :other_function, %{}}
  end

  test "it returns remaining calls when available" do
    MockServer.set(:some_function, %{}, {:ok, 1234})
    MockServer.set(:other_function, %{"which" => "is not called"}, {:ok, 5678})

    {:ok, 1234} = MockServer.call_and_get_mock_value(:some_function, %{})

    assert MockServer.remaining_calls() == %{{:other_function, %{"which" => "is not called"}} => [ok: 5678]}
  end

  test "if no remaining calls are available it returns an empty list" do
    MockServer.set(:some_function, %{}, {:ok, 1234})
    {:ok, 1234} = MockServer.call_and_get_mock_value(:some_function, %{})

    assert MockServer.remaining_calls() == %{}
  end
end
