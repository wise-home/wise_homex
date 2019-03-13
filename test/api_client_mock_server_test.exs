defmodule ApiClientMockServerTest do
  use ExUnit.Case, async: true

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
             {:error, "No mock set on non_existing with options %{hej: true}"}
  end

  test "it returns an error getting a value for a non existing mock where only opts differ" do
    MockServer.set(
      :other_function,
      %{"include" => "french_fries"},
      {:ok, 1234}
    )

    assert MockServer.call_and_get_mock_value(:other_function, %{}) ==
             {:error, "No mock set on other_function with options %{}"}
  end
end
