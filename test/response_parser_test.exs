defmodule WiseHomex.ResponseParserTest do
  use WiseHomex.Test.Case, async: true

  alias WiseHomex.ResponseParser

  test "error message in plain text" do
    assert {:service_not_available, nil} = ResponseParser.parse_response(503, "Service unavailable - nginx")
  end
end
