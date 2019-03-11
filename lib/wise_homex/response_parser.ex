defmodule WiseHomex.ResponseParser do
  @moduledoc """
  Parses http responses from the api client
  """

  @type response ::
          {:ok, struct | [struct] | :empty}
          | {:invalid_request, map | nil}
          | {:not_authorized, map | nil}
          | {:not_found, map | nil}
          | :server_error
          | :bad_gateway
          | {:service_not_available, map | nil}

  @doc """
  Parses a HTTP response given the status code and text body
  """
  @spec parse_response(integer, String.t()) :: response
  def parse_response(status_code, "") do
    parse_json_response(status_code, nil)
  end

  def parse_response(status_code, body) when status_code in 200..299 do
    json = Jason.decode!(body)
    parse_json_response(status_code, json)
  end

  def parse_response(status_code, body) do
    json =
      case Jason.decode(body) do
        {:ok, json} -> json
        _error -> nil
      end

    parse_json_response(status_code, json)
  end

  defp parse_json_response(status_code, json) when status_code in 200..201 do
    {:ok, WiseHomex.JSONParser.parse(json)}
  end

  defp parse_json_response(204, nil) do
    {:ok, :empty}
  end

  defp parse_json_response(400, json) do
    {:invalid_request, json}
  end

  defp parse_json_response(401, json) do
    {:not_authorized, json}
  end

  defp parse_json_response(404, json) do
    {:not_found, json}
  end

  defp parse_json_response(500, _json) do
    :server_error
  end

  defp parse_json_response(502, nil) do
    :bad_gateway
  end

  defp parse_json_response(503, json) do
    {:service_not_available, json}
  end
end
