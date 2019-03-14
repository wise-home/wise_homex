defmodule WiseHomex.ApiClientTest do
  use ExUnit.Case

  alias WiseHomex.Test.ApiClientMockServer, as: MockServer

  setup do
    MockServer.start_link()

    :ok
  end

  describe "ping" do
    test "it calls ping with the expected includes" do
      MockServer.set(:ping, %{query: %{"include" => "user,account"}}, {:ok, 1234})

      config = WiseHomex.new_config(:api_key, "somekey")
      {:ok, 1234} = config |> WiseHomex.ping(%{"include" => "user,account"})
      assert MockServer.called?(:ping) == %{query: %{"include" => "user,account"}}
    end
  end

  describe "get_account_users" do
    test "it calls get_account_users with the expected includes and filters" do
      MockServer.set(
        :get_account_users,
        %{query: %{"include" => "user", "filter[role]" => "tenant"}},
        {:ok, %WiseHomex.Device{}}
      )

      config = WiseHomex.new_config(:api_key, "somekey")

      {:ok, _account_users} =
        config |> WiseHomex.get_account_users(%{"include" => "user", "filter[role]" => "tenant"})

      assert MockServer.called?(:get_account_users) == %{
               query: %{"filter[role]" => "tenant", "include" => "user"}
             }
    end
  end
end
