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

  use WiseHomex.Creator

  @doc """
  Get a guest configuration without an api key for the API Client
  """
  defdelegate anonymous_config(opts \\ []), to: WiseHomex.Config

  @doc """
  Get a new configuration for the API Client
  """
  defdelegate new_config(auth_type, credentials, opts \\ []), to: WiseHomex.Config

  # Get the ApiClient implementation to use
  defp api_client(), do: Application.get_env(:wise_homex, :api_client_impl, WiseHomex.ApiClientImpl)

  # Account User

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
  Delete an account_user
  """
  def delete_account_user(config, id), do: api_client().delete_account_user(config, id)

  # Address

  @doc """
  Create an address
  """
  def create_address(config, attrs, rels), do: api_client().create_address(config, attrs, rels)

  @doc """
  Update an address
  """
  def update_address(config, id, attrs), do: api_client().update_address(config, id, attrs)

  @doc """
  Get an address
  """
  def get_address(config, id, query \\ %{}), do: api_client().get_address(config, id, query)

  @doc """
  List addresses
  """
  def get_addresses(config, query \\ %{}), do: api_client().get_addresses(config, query)

  # Admin Integration

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

  # Admin Integration UNIK

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

  # Angel Note

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

  # Bmeters Keys

  @doc """
  Upload a bmeters key file
  """
  def upload_bmeters_keys(config, opts), do: api_client().upload_bmeters_keys(config, opts)

  # Device

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
  def set_device_location(config, device_id, attrs, rels),
    do: api_client().set_device_location(config, device_id, attrs, rels)

  @doc """
  Unset device location
  """
  def unset_device_location(config, device_id), do: api_client().unset_device_location(config, device_id)

  @doc """
  Update a device
  """
  def update_device(config, id, attrs, rels), do: api_client().update_device(config, id, attrs, rels)

  @doc """
  Import devices from CSV
  """
  def import_devices(config, attrs, rels), do: api_client().import_devices(config, attrs, rels)

  # Email Settings

  @doc """
  Update EmailSettings for a device
  """
  def update_account_email_settings(config, account_id, id, attrs),
    do: api_client().update_account_email_settings(config, account_id, id, attrs)

  # External Info

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

  # Firmware

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

  # Fiscal Year

  @doc """
  Get multiple fiscal years
  """
  def get_fiscal_years(config, query \\ %{}), do: api_client().get_fiscal_years(config, query)

  @doc """
  Get a single fiscal year
  """
  def get_fiscal_year(config, id, query \\ %{}), do: api_client().get_fiscal_year(config, id, query)

  @doc """
  Create a fiscal year
  """
  def create_fiscal_year(config, attrs, rels), do: api_client().create_fiscal_year(config, attrs, rels)

  @doc """
  Update a fiscal year
  """
  def update_fiscal_year(config, id, attrs, rels), do: api_client().update_fiscal_year(config, id, attrs, rels)

  @doc """
  Delete a fiscal year
  """
  def delete_fiscal_year(config, id), do: api_client().delete_fiscal_year(config, id)

  # Gateway

  @doc """
  Get a gateway
  """
  def get_gateway(config, id, query \\ %{}), do: api_client().get_gateway(config, id, query)

  @doc """
  Get multiple gateways
  """
  def get_gateways(config, query \\ %{}), do: api_client().get_gateways(config, query)

  @doc """
  Delete a gateway

  Deleting a gateway with devices will return an error.
  """
  def delete_gateway(config, id), do: api_client().delete_gateway(config, id)

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

  # HeatSource

  @doc """
  Get heat source by id
  """
  def get_heat_source(config, id, query \\ %{}), do: api_client().get_heat_source(config, id, query)

  @doc """
  Gets heat sources
  """
  def get_heat_sources(config, query \\ %{}), do: api_client().get_heat_sources(config, query)

  # Household

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

  # Account invitation

  @doc """
  Create an account invitation
  """
  def create_account_invitation(config, account_id, attrs),
    do: api_client().create_account_invitation(config, account_id, attrs)

  # KEM uploads

  @doc """
  Upload a KEM file
  """
  def upload_kem(config, opts), do: api_client().upload_kem(config, opts)

  # Ping

  @doc """
  Ping the Wise Home API to check availability and get authentication status.

  * Optional includes: `user`, `account`

  Example:

  ```
  config |> WiseHomex.ping(%{"include" => "user,accont"})
  ```
  """
  def ping(config, query), do: api_client().ping(config, query)

  # Property

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

  # Property Syncs

  @doc """
  Trigger sync of an existing property
  """
  def sync_property(config, property_id), do: api_client().sync_property(config, property_id)

  # Property Syncs UNIK

  @doc """
  Create a synced property from unik
  """
  def create_synced_property_unik(config, property_number, company_number, admin_id),
    do: api_client().create_synced_property_unik(config, property_number, company_number, admin_id)

  # Reports

  @doc """
  Get reports for a device
  """
  def get_device_reports(config, id), do: api_client().get_device_reports(config, id)

  @doc """
  Create latest report for a device
  """
  def create_latest_report(config, device_id, query \\ %{}),
    do: api_client().create_latest_report(config, device_id, query)

  # Radiator

  @doc """
  Get a radiator
  """
  def get_radiator(config, id, query \\ %{}), do: api_client().get_radiator(config, id, query)

  @doc """
  Get multiple radiators
  """
  def get_radiators(config, query \\ %{}), do: api_client().get_radiators(config, query)

  @doc """
  Import radiators
  """
  def import_radiators(config, attrs), do: api_client().import_radiators(config, attrs)

  # Radiator Info

  @doc """
  Get an url to info about a radiator
  """
  def get_radiator_info(config, id), do: api_client().get_radiator_info(config, id)

  # Room

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

  # Tenancy

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

  # SettlementKey

  @doc """
  Get SettlementKey by id
  """
  def get_settlement_key(config, id, query \\ %{}), do: api_client().get_settlement_key(config, id, query)

  @doc """
  List SettlementKeys
  """
  def get_settlement_keys(config, query), do: api_client().get_settlement_keys(config, query)

  @doc """
  Create a settlement key
  """
  def create_settlement_key(config, attrs, rels), do: api_client().create_settlement_key(config, attrs, rels)

  @doc """
  Update a settlement key
  """
  def update_settlement_key(config, id, attrs), do: api_client().update_settlement_key(config, id, attrs)

  @doc """
  Delete a settlement key
  """
  def delete_settlement_key(config, id), do: api_client().delete_settlement_key(config, id)

  # SettlementValue

  @doc """
  Get a settlement value by id
  """
  def get_settlement_value(config, id, query \\ %{}), do: api_client().get_settlement_value(config, id, query)

  @doc """
  Create a settlement value
  """
  def create_settlement_value(config, attrs, rels), do: api_client().create_settlement_value(config, attrs, rels)

  @doc """
  Create a settlement value
  """
  def update_settlement_value(config, id, attrs), do: api_client().update_settlement_value(config, id, attrs)

  @doc """
  Deletes a settlement value
  """
  def delete_settlement_value(config, id), do: api_client().delete_settlement_value(config, id)

  # SIM

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

  # Statement

  @doc """
  Get a Statement by id
  """
  def get_statement(config, id, query \\ %{}), do: api_client().get_statement(config, id, query)

  @doc """
  Get multiple statements
  """
  def get_statements(config, query \\ %{}), do: api_client().get_statements(config, query)

  @doc """
  Create a statement
  """
  def create_statement(config, attrs, rels), do: api_client().create_statement(config, attrs, rels)

  @doc """
  Update a statement
  """
  def update_statement(config, id, attrs), do: api_client().update_statement(config, id, attrs)

  @doc """
  Delete a statement
  """
  def delete_statement(config, id), do: api_client().delete_statement(config, id)

  # User

  @doc """
  Get multiple users
  """
  def get_users(config, filters \\ []), do: api_client().get_users(config, filters)

  # UtilityReading

  @doc """
  Get UtilityReading by id
  """
  def get_utility_reading(config, id, query \\ %{}), do: api_client().get_utility_reading(config, id, query)

  @doc """
  Get UtilityReadings
  """
  def get_utility_readings(config, query \\ %{}), do: api_client().get_utility_readings(config, query)

  @doc """
  Create a UtilityReading
  """
  def create_utility_reading(config, attrs, rels), do: api_client().create_utility_reading(config, attrs, rels)

  @doc """
  Update a UtilityReading
  """
  def update_utility_reading(config, id, attrs, rels), do: api_client().update_utility_reading(config, id, attrs, rels)

  @doc """
  Delete a UtilityReading
  """
  def delete_utility_reading(config, id), do: api_client().delete_utility_reading(config, id)

  # Wmbus Cache

  @doc """
  Get wmbus cache
  """
  def get_wmbus_cache(config, gateway_id, query \\ %{}), do: api_client().get_wmbus_cache(config, gateway_id, query)

  @doc """
  Refresh wmbus cache
  """
  def refresh_wmbus_cache(config, gateway_id), do: api_client().refresh_wmbus_cache(config, gateway_id)

  @doc """
  Get zip codes and citites
  """
  def get_zip_codes(config), do: api_client().get_zip_codes(config)
end
