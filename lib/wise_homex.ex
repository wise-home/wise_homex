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

  # Account invitation

  @doc """
  Create an account invitation
  """
  def create_account_invitation(config, account_id, attrs),
    do: api_client().create_account_invitation(config, account_id, attrs)

  # Add start readings

  @doc """
  Add zero-valued start readings for all devices that does not have any readings near the start of a statement period
  """
  def add_start_readings(config, statement_id), do: api_client().add_start_readings(config, statement_id)

  # Angel Note

  @doc """
  Get an angel note by a `target_type` and a `target_id`
  """
  def get_angel_note(config, target_type, target_id), do: api_client().get_angel_note(config, target_type, target_id)

  # Bmeters Keys

  @doc """
  Upload a bmeters key file
  """
  def upload_bmeters_keys(config, opts), do: api_client().upload_bmeters_keys(config, opts)

  # Calculate missing readings
  def calculate_missing_readings(config, statement_id),
    do: api_client().calculate_missing_readings(config, statement_id)

  # Device

  @doc """
  Import devices from CSV
  """
  def import_devices(config, attrs, rels), do: api_client().import_devices(config, attrs, rels)

  # Device Balancer

  @doc """
  Rebalance devices
  """
  def rebalance_devices(config, admin_id), do: api_client().rebalance_devices(config, admin_id)

  # Email Settings

  @doc """
  Update EmailSettings for a device
  """
  def update_account_email_settings(config, account_id, id, attrs),
    do: api_client().update_account_email_settings(config, account_id, id, attrs)

  # Gateway

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
  Import radiators
  """
  def import_radiators(config, attrs), do: api_client().import_radiators(config, attrs)

  # READy
  def ready_installation_matches(config, rels, query \\ %{}),
    do: api_client().ready_installation_matches(config, rels, query)

  def ready_installation_already_matched(config, rels, query \\ %{}),
    do: api_client().ready_installation_already_matched(config, rels, query)

  def link_ready_installation_match(config, rels, query \\ %{}),
    do: api_client().link_ready_installation_match(config, rels, query)

  def unlink_ready_installation_match(config, rels, query \\ %{}),
    do: api_client().unlink_ready_installation_match(config, rels, query)

  # Statement

  @doc """
  Create the next statement from a current statement
  """
  def create_next_statement(config, prev_statement_id, query \\ %{}),
    do: api_client().create_next_statement(config, prev_statement_id, query)

  # Wmbus Cache

  @doc """
  Get wmbus cache
  """
  def get_wmbus_cache(config, gateway_id, query \\ %{}), do: api_client().get_wmbus_cache(config, gateway_id, query)

  @doc """
  Refresh wmbus cache
  """
  def refresh_wmbus_cache(config, gateway_id), do: api_client().refresh_wmbus_cache(config, gateway_id)
end
