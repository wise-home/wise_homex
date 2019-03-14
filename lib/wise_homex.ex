defmodule WiseHomex do
  @moduledoc """
  Api Client for Wise Home

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
  """

  @doc """
  Get a new configuration for the API Client
  """
  defdelegate new_config(auth_type, credentials, opts \\ []), to: WiseHomex.Config

  @doc """
  Create an account
  """
  defdelegate create_account(config, attributes, rels), to: WiseHomex.ApiClient

  @doc """
  Delete an account
  """
  defdelegate delete_account(config, id), to: WiseHomex.ApiClient

  @doc """
  Get an account
  """
  defdelegate get_account(config, id, query \\ %{}), to: WiseHomex.ApiClient

  @doc """
  Get multiple accounts
  """
  defdelegate get_accounts(config, query \\ %{}), to: WiseHomex.ApiClient

  @doc """
  Update an account
  """
  defdelegate update_account(config, id, attrs), to: WiseHomex.ApiClient

  @doc """
  Gets the account users for the current user.

  * Optional includes: `user`, `account`
  * Optional filters: `role`, `account_id`

  Example:

  ```
  config |> WiseHomex.get_account_users(%{"include" => "user", "filter[role]" => "tenant"})
  ```
  """
  defdelegate get_account_users(config, query), to: WiseHomex.ApiClient

  @doc """
  Create an address
  """
  defdelegate create_address(config, attrs, rels), to: WiseHomex.ApiClient

  @doc """
  Get an address
  """
  defdelegate get_address(config, id, query \\ %{}), to: WiseHomex.ApiClient

  @doc """
  Upload a bmeters key file
  """
  defdelegate upload_bmeters_keys(config, opts), to: WiseHomex.ApiClient

  @doc """
  Add a device
  """
  defdelegate add_device(config, gateway_id, protocol, serial), to: WiseHomex.ApiClient

  @doc """
  Authorize a device
  """
  defdelegate authorize_device(config, device_id), to: WiseHomex.ApiClient

  @doc """
  Deauthorize a device
  """
  defdelegate deauthorize_device(config, device_id), to: WiseHomex.ApiClient

  @doc """
  Delete a device
  """
  defdelegate delete_device(config, id), to: WiseHomex.ApiClient

  @doc """
  Fast ping a device
  """
  defdelegate fast_ping_device(config, id), to: WiseHomex.ApiClient

  @doc """
  Get a device
  """
  defdelegate get_device(config, id, query \\ %{}), to: WiseHomex.ApiClient

  @doc """
  Get multiple devices
  """
  defdelegate get_devices(config, query \\ %{}), to: WiseHomex.ApiClient

  @doc """
  Set device location
  """
  defdelegate set_device_location(config, device_id, room_id), to: WiseHomex.ApiClient

  @doc """
  Update a device
  """
  defdelegate update_device(config, id, attrs, rels), to: WiseHomex.ApiClient

  @doc """
  Update EmailSettings for a device
  """
  defdelegate update_account_email_settings(config, account_id, id, attrs),
    to: WiseHomex.ApiClient

  @doc """
  Create firmware
  """
  defdelegate create_firmware(config, file_content), to: WiseHomex.ApiClient

  @doc """
  Delete firmware
  """
  defdelegate delete_firmware(config, id), to: WiseHomex.ApiClient

  @doc """
  Get firmwares
  """
  defdelegate get_firmwares(config), to: WiseHomex.ApiClient

  @doc """
  Get a gateway
  """
  defdelegate get_gateway(config, id, query \\ %{}), to: WiseHomex.ApiClient

  @doc """
  Get multiple gateways
  """
  defdelegate get_gateways(config, query \\ %{}), to: WiseHomex.ApiClient

  @doc """
  Lock a gateway
  """
  defdelegate lock_gateway(config, id), to: WiseHomex.ApiClient

  @doc """
  Restart a gateway
  """
  defdelegate restart_gateway(config, id), to: WiseHomex.ApiClient

  @doc """
  Unlock a gateway
  """
  defdelegate unlock_gateway(config, id, seconds), to: WiseHomex.ApiClient

  @doc """
  Update a gateway
  """
  defdelegate update_gateway(config, id, attrs, rels \\ %{}), to: WiseHomex.ApiClient

  @doc """
  Create a household
  """
  defdelegate create_household(config, attrs, rels), to: WiseHomex.ApiClient

  @doc """
  Delete a household
  """
  defdelegate delete_household(config, id), to: WiseHomex.ApiClient

  @doc """
  Get a household
  """
  defdelegate get_household(config, id, query \\ %{}), to: WiseHomex.ApiClient

  @doc """
  Get multiple households
  """
  defdelegate get_households(config, query \\ %{}), to: WiseHomex.ApiClient

  @doc """
  Update a household
  """
  defdelegate update_household(config, id, attrs, rels), to: WiseHomex.ApiClient

  @doc """
  Create an account invitation
  """
  defdelegate create_account_invitation(config, account_id, attrs), to: WiseHomex.ApiClient

  @doc """
  Upload a KEM file
  """
  defdelegate upload_kem(config, opts), to: WiseHomex.ApiClient

  @doc """
  Ping the Wise Home API to check availability and get authentication status.

  * Optional includes: `user`, `account`

  Example:

  ```
  config |> WiseHomex.ping(%{"include" => "user,accont"})
  ```
  """
  defdelegate ping(config, query), to: WiseHomex.ApiClient

  @doc """
  Create a property
  """
  defdelegate create_property(config, attrs, rels), to: WiseHomex.ApiClient

  @doc """
  Delete a property
  """
  defdelegate delete_property(config, id), to: WiseHomex.ApiClient

  @doc """
  Get multiple properties
  """
  defdelegate get_properties(config, query \\ %{}), to: WiseHomex.ApiClient

  @doc """
  Get a property
  """
  defdelegate get_property(config, id, query \\ %{}), to: WiseHomex.ApiClient

  @doc """
  Update a property
  """
  defdelegate update_property(config, id, attrs, rels), to: WiseHomex.ApiClient

  @doc """
  Get reports for a device
  """
  defdelegate get_device_reports(config, id), to: WiseHomex.ApiClient

  @doc """
  Create latest report for a device
  """
  defdelegate create_latest_report(config, device_id, query \\ %{}), to: WiseHomex.ApiClient

  @doc """
  Create a room
  """
  defdelegate create_room(config, attrs, rels), to: WiseHomex.ApiClient

  @doc """
  Delete a room
  """
  defdelegate delete_room(config, id), to: WiseHomex.ApiClient

  @doc """
  Get a room
  """
  defdelegate get_room(config, id, query \\ %{}), to: WiseHomex.ApiClient

  @doc """
  Get multiple rooms
  """
  defdelegate get_rooms(config, query), to: WiseHomex.ApiClient

  @doc """
  Update a room
  """
  defdelegate update_room(config, id, attrs, rels), to: WiseHomex.ApiClient

  @doc """
  Create a tenancy
  """
  defdelegate create_tenancy(config, attrs, rels), to: WiseHomex.ApiClient

  @doc """
  Delete a tenancy
  """
  defdelegate delete_tenancy(config, id), to: WiseHomex.ApiClient

  @doc """
  Get a tenancy
  """
  defdelegate get_tenancy(config, id, query \\ %{}), to: WiseHomex.ApiClient

  @doc """
  Update a tenancy
  """
  defdelegate update_tenancy(config, id, attrs), to: WiseHomex.ApiClient

  @doc """
  Create a sim card
  """
  defdelegate create_sim(config, attrs), to: WiseHomex.ApiClient

  @doc """
  Delete a sim card
  """
  defdelegate delete_sim(config, id), to: WiseHomex.ApiClient

  @doc """
  Get a sim card
  """
  defdelegate get_sim(config, id, query \\ %{}), to: WiseHomex.ApiClient

  @doc """
  Get multiple sim cards
  """
  defdelegate get_sims(config, query \\ %{}), to: WiseHomex.ApiClient

  @doc """
  Update a sim card
  """
  defdelegate update_sim(config, id, attrs), to: WiseHomex.ApiClient

  @doc """
  Get multiple users
  """
  defdelegate get_users(config, filters \\ []), to: WiseHomex.ApiClient

  @doc """
  Get wmbus cache
  """
  defdelegate get_wmbus_cache(config, gateway_id, query \\ %{}), to: WiseHomex.ApiClient

  @doc """
  Refresh wmbus cache
  """
  defdelegate refresh_wmbus_cache(config, gateway_id), to: WiseHomex.ApiClient
end
