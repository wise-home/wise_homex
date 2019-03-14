defmodule WiseHomex.ApiClientTest do
  use ExUnit.Case, async: true

  alias WiseHomex.Test.Mock

  setup do
    Mock.start_link()

    :ok
  end

  describe "ping" do
    test "it calls ping with the expected includes" do
      config = WiseHomex.new_config(:api_key, "somekey")
      config |> WiseHomex.ping(%{"include" => "user,account"})

      assert Mock.called?(:get, "/ping") == %{"include" => "user,account"}
    end
  end

  describe "get_account_users" do
    test "it calls get_account_users with the expected includes and filters" do
      config = WiseHomex.new_config(:api_key, "somekey")
      config |> WiseHomex.get_account_users(%{"include" => "user", "filter[role]" => "tenant"})

      assert Mock.called?(:get, "/account-users") == %{
               "filter[role]" => "tenant",
               "include" => "user"
             }
    end
  end
end
