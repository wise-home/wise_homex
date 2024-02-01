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

      prepared_query = Request.prepare_query(query)

      assert length(prepared_query) == 3

      assert Enum.member?(prepared_query, {"cool", "true"})
      assert Enum.member?(prepared_query, {"id", "99"})
      assert Enum.member?(prepared_query, {"name", "Cool Herc"})
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

      prepared_query = Request.prepare_query(query)

      assert length(prepared_query) == 5

      assert Enum.member?(prepared_query, {"filter[target-ids][]", "22"})
      assert Enum.member?(prepared_query, {"filter[target-ids][]", "25"})
      assert Enum.member?(prepared_query, {"filter[target-ids][]", "39"})
      assert Enum.member?(prepared_query, {"filter[target-ids][]", "44"})
      assert Enum.member?(prepared_query, {"include", "property"})
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

      # expect "/api/xx?cool=true&filter[target-ids][]=22&filter[target-ids][]=25&filter[target-ids][]=39&filter[target-ids][]=44&id=99&include=property&target[name]=Cool+Herc"
      uri = URI.parse(path)
      assert uri.path == "/api/xx"

      query = uri.query

      assert String.length(query) == 151

      querty_elements = String.split(query, "&")

      assert Enum.member?(querty_elements, "cool=true")
      assert Enum.member?(querty_elements, "filter[target-ids][]=22")
      assert Enum.member?(querty_elements, "filter[target-ids][]=25")
      assert Enum.member?(querty_elements, "filter[target-ids][]=39")
      assert Enum.member?(querty_elements, "filter[target-ids][]=44")
      assert Enum.member?(querty_elements, "id=99")
      assert Enum.member?(querty_elements, "include=property")
      assert Enum.member?(querty_elements, "target[name]=Cool+Herc")
    end
  end
end
