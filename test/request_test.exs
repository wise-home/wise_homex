defmodule WiseHomex.RequestTest do
  @moduledoc """
  Tests for WiseHomex.Request
  """

  use WiseHomex.Test.Case

  alias WiseHomex.Request

  describe "prepare_query" do
    test "handles maps with atom keys and strings, booleans, integers" do
      query = %{
        cool: true,
        id: 99,
        name: "Cool Herc"
      }

      assert Request.prepare_query(query) == [{"cool", "true"}, {"id", "99"}, {"name", "Cool Herc"}]
    end

    test "handles maps with string keys and strings, booleans, integers" do
      query = %{
        "cool" => true,
        "id" => 99,
        "target[name]" => "Cool Herc"
      }

      assert Request.prepare_query(query) == [{"cool", "true"}, {"id", "99"}, {"target[name]", "Cool Herc"}]
    end

    test "handles lists of numbers and merges with other fields" do
      query = %{
        "filter[target-ids]" => [22, 25, 39, 44],
        "include" => "property"
      }

      assert Request.prepare_query(query) == [
               {"filter[target-ids][]", "22"},
               {"filter[target-ids][]", "25"},
               {"filter[target-ids][]", "39"},
               {"filter[target-ids][]", "44"},
               {"include", "property"}
             ]
    end

    test "handles lists of strings" do
      query = %{
        "filter[target-ids]" => ["11", "23", "34", "45"]
      }

      assert Request.prepare_query(query) == [
               {"filter[target-ids][]", "11"},
               {"filter[target-ids][]", "23"},
               {"filter[target-ids][]", "34"},
               {"filter[target-ids][]", "45"}
             ]
    end

    test "handles empty map" do
      assert Request.prepare_query(%{}) == []
    end
  end

  describe "path_with_query" do
    test "handles empty map" do
      assert Request.path_with_query("/api/xx", %{}) == "/api/xx"
    end

    test "handles a map with boolean, string, list and number" do
      query = %{
        "cool" => true,
        "filter[target-ids]" => [22, 25, 39, 44],
        "id" => 99,
        "include" => "property",
        "target[name]" => "Cool Herc"
      }

      path = Request.path_with_query("/api/xx", query) |> URI.decode()

      assert path ==
               "/api/xx?cool=true&filter[target-ids][]=22&filter[target-ids][]=25&filter[target-ids][]=39&filter[target-ids][]=44&id=99&include=property&target[name]=Cool+Herc"
    end
  end
end
