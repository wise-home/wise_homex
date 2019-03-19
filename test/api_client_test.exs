defmodule WiseHomex.ApiClientTest do
  use ExUnit.Case

  alias WiseHomex.Test.ApiClientMockServer, as: MockServer

  setup do
    MockServer.start_link()
    config = WiseHomex.new_config(:api_key, "somekey")

    {:ok, %{config: config}}
  end

  describe "get_account_users" do
    test "it calls get_account_users with the expected includes and filters", %{config: config} do
      MockServer.set(
        :get_account_users,
        %{query: %{"include" => "user", "filter[role]" => "tenant"}},
        {:ok, %WiseHomex.Device{}}
      )

      {:ok, _account_users} = config |> WiseHomex.get_account_users(%{"include" => "user", "filter[role]" => "tenant"})

      assert MockServer.called?(:get_account_users) == %{
               query: %{"filter[role]" => "tenant", "include" => "user"}
             }
    end
  end

  describe "angel notes" do
    test "it gets an angel note", %{config: config} do
      MockServer.set(
        :get_angel_note,
        %{target_type: "devices", target_id: "100"},
        {:ok, %WiseHomex.AngelNote{}}
      )

      {:ok, _angel_note} = config |> WiseHomex.get_angel_note("devices", "100")

      assert MockServer.called?(:get_angel_note) == %{target_type: "devices", target_id: "100"}
    end
  end

  describe "ping" do
    test "it calls ping with the expected includes", %{config: config} do
      MockServer.set(:ping, %{query: %{"include" => "user,account"}}, {:ok, 1234})

      {:ok, 1234} = config |> WiseHomex.ping(%{"include" => "user,account"})
      assert MockServer.called?(:ping) == %{query: %{"include" => "user,account"}}
    end
  end
end
