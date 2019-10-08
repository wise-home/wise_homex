defmodule WiseHomex.Request do
  @moduledoc """
  Helper to make requests from the ApiClient including settings headers and generating paths.
  """

  alias WiseHomex.Config
  alias WiseHomex.ResponseParser

  def get(config, path, query \\ %{}) do
    headers = build_headers(config)
    options = build_options(config)

    path
    |> path_with_query(query)
    |> versionise_path(config)
    |> add_base_url(config)
    |> HTTPoison.get(headers, options)
    |> parse_response()
  end

  def post(config, path, body \\ %{}) when is_map(body) do
    headers = build_headers(config)
    options = build_options(config)

    path
    |> versionise_path(config)
    |> add_base_url(config)
    |> HTTPoison.post(body |> Jason.encode!(), headers, options)
    |> parse_response()
  end

  def post(config, path, query, body) when is_map(query) and is_map(body) do
    post(config, path |> path_with_query(query), body)
  end

  def patch(config, path, params) do
    headers = build_headers(config)
    body = Jason.encode!(params)
    options = build_options(config)

    path
    |> versionise_path(config)
    |> add_base_url(config)
    |> HTTPoison.patch(body, headers, options)
    |> parse_response()
  end

  def delete(config, path) do
    headers = build_headers(config)
    options = build_options(config)

    path
    |> versionise_path(config)
    |> add_base_url(config)
    |> HTTPoison.delete(headers, options)
    |> parse_response
  end

  # Take a path and append it with an encoded query string
  @spec path_with_query(binary(), map()) :: binary()
  defp path_with_query(path, query) do
    query
    |> URI.encode_query()
    |> case do
      "" -> path
      query_string -> "#{path}?#{query_string}"
    end
  end

  # Add the used api_version to the path
  defp versionise_path(path, %Config{api_version: api_version}),
    do: "/" <> api_version <> path

  defp add_base_url(path, %Config{base_url: base_url}), do: base_url <> path

  # Build HTTP request headers from an ApiClient.Config
  defp build_headers(%Config{authorization_header: authorization_header}) do
    %{"content-type" => "application/vnd.api+json"}
    |> add_authorization_header(authorization_header)
  end

  # Conditionally add the authorization header to a map of headers
  defp add_authorization_header(headers, nil), do: headers
  defp add_authorization_header(headers, auth_header), do: headers |> Map.put(:authorization, auth_header)

  # Build options for HTTPoison from an ApiClient.Config
  defp build_options(%Config{timeout: timeout}) do
    [recv_timeout: timeout]
  end

  defp parse_response({:ok, %{status_code: status_code, body: body}}) do
    ResponseParser.parse_response(status_code, body)
  end

  defp parse_response({:error, %{reason: reason}}) do
    case reason do
      :econnrefused -> :econnrefused
      :connect_timeout -> :connect_timeout
      :timeout -> :timeout
      :closed -> :closed
    end
  end
end
