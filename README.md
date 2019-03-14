# Wise Home API Client for Elixir

**This api client is currently under development, and is currently only for internal use in [Wise Home](https://wisehome.dk).**


## Usage:

### Getting a configuration

First, get a configuration struct by invoking `new_config/2` or `new_config/3` with either `:api_key`, `:plain` or `:auth_header` as first argument.

```
config = WiseHomex.new_config(:api_key, "your_api_key")
config = WiseHomex.new_config(:plain, {"user_name", "password"})
config = WiseHomex.new_config(:auth_header, "auth_header")
```

Optionally you can call `new_config/3` with a keyword list for overriding the default configuration values, `base_url`, `timeout` and `api_version`

```
config = WiseHomex.new_config(:api_key, "your_api_key", timeout: 60_000, base_url: "https://another.wisehome.server.dk", api_version: "v4")
```

### Making requests

Next, use that `config` to do requests to the Wise Home API.

```
config |> WiseHomex.get_gateways()
```

Most `GET`-requests have a `query` that will be encoded and included.

```
config |> WiseHomex.get_gateways(%{"include" => "sim"})
```

Many `POST` and `PATCH` requests take a map for `attributes` and `relationships` for the created or updated entity, for example:

```
attributes = %{move_in_date: "2019-01-01", move_out_date: "2019-02-01"}

relationships = %{
  "household" => %{
    data: %{
      type: "households",
      id: "123"
    }
  },
  "tenant" => %{
    data: %{
      type: "accounts",
      id: "987"
    }
  }
}

config |> WiseHomex.create_tenancy(attributes, relationships)
```

If the request is successful, you will receive a response of the `{:ok, data}` where data is the included Ecto models. If the response is empty, the response will be {:ok, :empty}

If unsuccessful, the response will be one of

```
{:invalid_request, map | nil}
{:not_authorized, map | nil}
{:not_found, map | nil}
:server_error
:bad_gateway
{:service_not_available, map | nil}
:econnrefused
:connect_timeout
:closed
```


## Testing

The WiseHomex Api Client can be mocked during tests. By default the client uses the http implementation, but it can be overridden by setting in your `config/test.exs` file:

```
# Use the WiseHomex ApiMock
config :wise_homex, :api_client_impl, WiseHomex.Test.ApiClientMock
```

This will make all api calls reach the WiseHomex mock instead. Since the mock is a genserver, it needs to be started before all tests, and the tests cannot be async at this time.

A sample test:

```elixir
defmodule MyModule.SampleTest do
  use ExUnit.Case

  alias WiseHomex.Test.ApiClientMockServer, as: MockServer

  describe "ping" do
    test "it calls ping with the expected includes" do
      MockServer.start_link()
      MockServer.set(:ping, %{query: %{"include" => "user,account"}}, {:ok, :put_mock_response_here})

      config = WiseHomex.new_config(:api_key, "test")
      {:ok, _response} = config |> WiseHomex.ping(%{"include" => "user,account"})
      assert MockServer.called?(:ping) == %{query: %{"include" => "user,account"}}
    end
  end
end
```
