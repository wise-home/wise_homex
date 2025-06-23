defmodule WiseHomex.ApiDefinitionTest do
  use WiseHomex.Test.Case

  alias WiseHomex.ApiDefinition
  doctest ApiDefinition

  describe "type_to_model_mappings" do
    test "produces expected output" do
      api_config = [
        %{type: "accounts", model: WiseHomex.Account},
        %{type: "account-users", model: WiseHomex.AccountUser}
      ]

      assert WiseHomex.ApiDefinition.Reader.type_to_model_mappings(api_config) == %{
               "accounts" => WiseHomex.Account,
               "account-users" => WiseHomex.AccountUser
             }
    end

    test "does not raise if defining two identical types with identical model" do
      api_config = [
        %{type: "accounts", model: WiseHomex.Account},
        %{type: "accounts", model: WiseHomex.Account}
      ]

      assert WiseHomex.ApiDefinition.Reader.type_to_model_mappings(api_config) == %{"accounts" => WiseHomex.Account}
    end

    test "raises if defining two identical types with different models" do
      api_config = [
        %{type: "accounts", model: WiseHomex.AccountUser},
        %{type: "accounts", model: WiseHomex.Account}
      ]

      assert_raise(ArgumentError, ~s[Multiple models defined for type "accounts"], fn ->
        WiseHomex.ApiDefinition.Reader.type_to_model_mappings(api_config)
      end)
    end
  end
end
