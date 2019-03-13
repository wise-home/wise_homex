defmodule WiseHomex.ApiClientTest do
  use ExUnit.Case, async: true

  alias WiseHomex.Test.ApiClientMock

  setup do
    ApiClientMock.start_link()

    :ok
  end

  describe "ping" do
    test "it calls ping with the expected includes" do
      config = WiseHomex.new_config(:api_key, "somekey")
      config |> WiseHomex.ping(%{"include" => "user,account"})

      assert ApiClientMock.called?(:ping) == %{query: %{"include" => "user,account"}}
    end
  end

  describe "get_account_users" do
    test "it calls get_account_users with the expected includes and filters" do
      config = WiseHomex.new_config(:api_key, "somekey")
      config |> WiseHomex.get_account_users(%{"include" => "user", "filter[role]" => "tenant"})

      assert ApiClientMock.called?(:get_account_users) == %{
               query: %{"filter[role]" => "tenant", "include" => "user"}
             }

      assert ApiClientMock.called?(:get_account_users) == %{
               query: %{"filter[role]" => "tenant", "include" => "user"}
             }
    end
  end
end
