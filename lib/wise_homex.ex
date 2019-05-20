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

  @behaviour WiseHomex.ApiClientBehaviour

  @doc """
  Get a new configuration for the API Client
  """
  defdelegate new_config(auth_type, credentials, opts \\ []), to: WiseHomex.Config

  # Get the ApiClient implementation to use
  defp api_client(), do: Application.get_env(:wise_homex, :api_client_impl, WiseHomex.ApiClientImpl)

  @doc """
  Create an account
  """
  def create_account(config, attributes, rels), do: api_client().create_account(config, attributes, rels)

  @doc """
  Delete an account
  """
  def delete_account(config, id), do: api_client().delete_account(config, id)

  @doc """
  Get an account
  """
  def get_account(config, id, query \\ %{}), do: api_client().get_account(config, id, query)

  @doc """
  Get multiple accounts
  """
  def get_accounts(config, query \\ %{}), do: api_client().get_accounts(config, query)

  @doc """
  Update an account
  """
  def update_account(config, id, attrs), do: api_client().update_account(config, id, attrs)

  @doc """
  Gets the account users for the current user.

  * Optional includes: `user`, `account`
  * Optional filters: `role`, `account_id`

  Example:

  ```
  config |> WiseHomex.get_account_users(%{"include" => "user", "filter[role]" => "tenant"})
  ```
  """
  def get_account_users(config, query \\ %{}), do: api_client().get_account_users(config, query)

  @doc """
  Create an address
  """
  def create_address(config, attrs, rels), do: api_client().create_address(config, attrs, rels)

  @doc """
  Get an address
  """
  def get_address(config, id, query \\ %{}), do: api_client().get_address(config, id, query)

  @doc """
  Get admin integrations
  """
  def get_admin_integrations(config, query \\ %{}), do: api_client().get_admin_integrations(config, query)

  @doc """
  Get admin integration
  """
  def get_admin_integration(config, id, query \\ %{}), do: api_client().get_admin_integration(config, id, query)

  @doc """
  Delete an admin integration
  """
  def delete_admin_integration(config, id), do: api_client().delete_admin_integration(config, id)

  @doc """
  Create a UNIK admin integration
  """
  def create_admin_integration_unik(config, attrs, rels),
    do: api_client().create_admin_integration_unik(config, attrs, rels)

  @doc """
  Update a UNIK admin integration
  """
  def update_admin_integration_unik(config, id, attrs),
    do: api_client().update_admin_integration_unik(config, id, attrs)

  @doc """
  Get an angel note by a `target_type` and a `target_id`
  """
  def get_angel_note(config, target_type, target_id), do: api_client().get_angel_note(config, target_type, target_id)

  @doc """
  Create an angel note

  * Required attributes: `target_type`, `target_id`, `content`
  """
  def create_angel_note(config, attrs), do: api_client().create_angel_note(config, attrs)

  @doc """
  Update an angel note

  * Only the `content` attribute can be changed
  """
  def update_angel_note(config, id, attrs), do: api_client().update_angel_note(config, id, attrs)

  @doc """
  Delete an angel note by its id
  """
  def delete_angel_note(config, id), do: api_client().delete_angel_note(config, id)

  @doc """
  Upload a bmeters key file
  """
  def upload_bmeters_keys(config, opts), do: api_client().upload_bmeters_keys(config, opts)

  @doc """
  Add a device
  """
  def add_device(config, gateway_id, protocol, serial),
    do: api_client().add_device(config, gateway_id, protocol, serial)

  @doc """
  Authorize a device
  """
  def authorize_device(config, device_id), do: api_client().authorize_device(config, device_id)

  @doc """
  Deauthorize a device
  """
  def deauthorize_device(config, device_id), do: api_client().deauthorize_device(config, device_id)

  @doc """
  Delete a device
  """
  def delete_device(config, id), do: api_client().delete_device(config, id)

  @doc """
  Fast ping a device
  """
  def fast_ping_device(config, id), do: api_client().fast_ping_device(config, id)

  @doc """
  Get a device
  """
  def get_device(config, id, query \\ %{}), do: api_client().get_device(config, id, query)

  @doc """
  Get multiple devices
  """
  def get_devices(config, query \\ %{}), do: api_client().get_devices(config, query)

  @doc """
  Set device location
  """
  def set_device_location(config, device_id, room_id), do: api_client().set_device_location(config, device_id, room_id)

  @doc """
  Update a device
  """
  def update_device(config, id, attrs, rels), do: api_client().update_device(config, id, attrs, rels)

  @doc """
  Update EmailSettings for a device
  """
  def update_account_email_settings(config, account_id, id, attrs),
    do: api_client().update_account_email_settings(config, account_id, id, attrs)

  @doc """
  Create ExternalInfo
  """
  def create_external_info(config, attrs, rels), do: api_client().create_external_info(config, attrs, rels)

  @doc """
  Update ExternalInfo
  """
  def update_external_info(config, id, attrs), do: api_client().update_external_info(config, id, attrs)

  @doc """
  Delete ExternalInfo
  """
  def delete_external_info(config, id), do: api_client().delete_external_info(config, id)

  @doc """
  Create firmware
  """
  def create_firmware(config, file_content), do: api_client().create_firmware(config, file_content)

  @doc """
  Delete firmware
  """
  def delete_firmware(config, id), do: api_client().delete_firmware(config, id)

  @doc """
  Get firmwares
  """
  def get_firmwares(config), do: api_client().get_firmwares(config)

  @doc """
  Get a gateway
  """
  def get_gateway(config, id, query \\ %{}), do: api_client().get_gateway(config, id, query)

  @doc """
  Get multiple gateways
  """
  def get_gateways(config, query \\ %{}), do: api_client().get_gateways(config, query)

  @doc """
  Lock a gateway
  """
  def lock_gateway(config, id), do: api_client().lock_gateway(config, id)

  @doc """
  Restart a gateway
  """
  def restart_gateway(config, id), do: api_client().restart_gateway(config, id)

  @doc """
  Unlock a gateway
  """
  def unlock_gateway(config, id, seconds), do: api_client().unlock_gateway(config, id, seconds)

  @doc """
  Update a gateway
  """
  def update_gateway(config, id, attrs, rels \\ %{}), do: api_client().update_gateway(config, id, attrs, rels)

  @doc """
  Create a household
  """
  def create_household(config, attrs, rels), do: api_client().create_household(config, attrs, rels)

  @doc """
  Delete a household
  """
  def delete_household(config, id), do: api_client().delete_household(config, id)

  @doc """
  Get a household
  """
  def get_household(config, id, query \\ %{}), do: api_client().get_household(config, id, query)

  @doc """
  Get multiple households
  """
  def get_households(config, query \\ %{}), do: api_client().get_households(config, query)

  @doc """
  Update a household
  """
  def update_household(config, id, attrs, rels), do: api_client().update_household(config, id, attrs, rels)

  @doc """
  Create an account invitation
  """
  def create_account_invitation(config, account_id, attrs),
    do: api_client().create_account_invitation(config, account_id, attrs)

  @doc """
  Upload a KEM file
  """
  def upload_kem(config, opts), do: api_client().upload_kem(config, opts)

  @doc """
  Ping the Wise Home API to check availability and get authentication status.

  * Optional includes: `user`, `account`

  Example:

  ```
  config |> WiseHomex.ping(%{"include" => "user,accont"})
  ```
  """
  def ping(config, query), do: api_client().ping(config, query)

  @doc """
  Create a property
  """
  def create_property(config, attrs, rels), do: api_client().create_property(config, attrs, rels)

  @doc """
  Delete a property
  """
  def delete_property(config, id), do: api_client().delete_property(config, id)

  @doc """
  Get multiple properties
  """
  def get_properties(config, query \\ %{}), do: api_client().get_properties(config, query)

  @doc """
  Get a property
  """
  def get_property(config, id, query \\ %{}), do: api_client().get_property(config, id, query)

  @doc """
  Update a property
  """
  def update_property(config, id, attrs, rels), do: api_client().update_property(config, id, attrs, rels)

  @doc """
  Get reports for a device
  """
  def get_device_reports(config, id), do: api_client().get_device_reports(config, id)

  @doc """
  Create latest report for a device
  """
  def create_latest_report(config, device_id, query \\ %{}),
    do: api_client().create_latest_report(config, device_id, query)

  @doc """
  Create a room
  """
  def create_room(config, attrs, rels), do: api_client().create_room(config, attrs, rels)

  @doc """
  Delete a room
  """
  def delete_room(config, id), do: api_client().delete_room(config, id)

  @doc """
  Get a room
  """
  def get_room(config, id, query \\ %{}), do: api_client().get_room(config, id, query)

  @doc """
  Get multiple rooms
  """
  def get_rooms(config, query), do: api_client().get_rooms(config, query)

  @doc """
  Update a room
  """
  def update_room(config, id, attrs, rels), do: api_client().update_room(config, id, attrs, rels)

  @doc """
  Create a tenancy
  """
  def create_tenancy(config, attrs, rels), do: api_client().create_tenancy(config, attrs, rels)

  @doc """
  Delete a tenancy
  """
  def delete_tenancy(config, id), do: api_client().delete_tenancy(config, id)

  @doc """
  Get a tenancy
  """
  def get_tenancy(config, id, query \\ %{}), do: api_client().get_tenancy(config, id, query)

  @doc """
  Update a tenancy
  """
  def update_tenancy(config, id, attrs), do: api_client().update_tenancy(config, id, attrs)

  @doc """
  Create a sim card
  """
  def create_sim(config, attrs), do: api_client().create_sim(config, attrs)

  @doc """
  Delete a sim card
  """
  def delete_sim(config, id), do: api_client().delete_sim(config, id)

  @doc """
  Get a sim card
  """
  def get_sim(config, id, query \\ %{}), do: api_client().get_sim(config, id, query)

  @doc """
  Get multiple sim cards
  """
  def get_sims(config, query \\ %{}), do: api_client().get_sims(config, query)

  @doc """
  Update a sim card
  """
  def update_sim(config, id, attrs), do: api_client().update_sim(config, id, attrs)

  @doc """
  Get multiple users
  """
  def get_users(config, filters \\ []), do: api_client().get_users(config, filters)

  @doc """
  Get wmbus cache
  """
  def get_wmbus_cache(config, gateway_id, query \\ %{}), do: api_client().get_wmbus_cache(config, gateway_id, query)

  @doc """
  Refresh wmbus cache
  """
  def refresh_wmbus_cache(config, gateway_id), do: api_client().refresh_wmbus_cache(config, gateway_id)
end
