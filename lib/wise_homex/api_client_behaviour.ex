defmodule WiseHomex.ApiClientBehaviour do
  @moduledoc """
  Defines the callbacks in the WiseHomex.ApiClient to ensure consistency between
  the ApiClient implementation and the ApiClient Mock and possibly other implementations.
  """

  alias WiseHomex.Config

  @type response :: WiseHomex.ResponseParser.response() | :econnrefused | :connect_timeout | :closed

  @type id :: String.t()
  @type unik_number :: String.t()
  @type query :: map
  @type attributes :: map
  @type relationships :: map

  # Account
  @callback create_account(Config.t(), attributes, relationships) :: response
  @callback delete_account(Config.t(), id) :: response
  @callback get_account(Config.t(), id, query) :: response
  @callback get_accounts(Config.t(), query) :: response
  @callback update_account(Config.t(), id, attributes) :: response

  # Account User
  @callback get_account_users(Config.t(), query) :: response

  # Address
  @callback create_address(Config.t(), attributes, relationships) :: response
  @callback get_address(Config.t(), id, query) :: response

  # Admin Integration
  @callback get_admin_integrations(Config.t(), query) :: response
  @callback get_admin_integration(Config.t(), id, query) :: response
  @callback delete_admin_integration(Config.t(), id) :: response
  @callback create_admin_integration_unik(Config.t(), attributes, relationships) :: response
  @callback update_admin_integration_unik(Config.t(), id, attributes) :: response

  # Angel Note
  @callback get_angel_note(Config.t(), String.t(), id) :: response
  @callback create_angel_note(Config.t(), attributes) :: response
  @callback update_angel_note(Config.t(), id, attributes) :: response
  @callback delete_angel_note(Config.t(), id) :: response

  # Bmeters Keys
  @callback upload_bmeters_keys(Config.t(), list) :: response

  # Device
  @callback add_device(Config.t(), id, String.t(), String.t()) :: response
  @callback authorize_device(Config.t(), id) :: response
  @callback deauthorize_device(Config.t(), id) :: response
  @callback delete_device(Config.t(), id) :: response
  @callback fast_ping_device(Config.t(), id) :: response
  @callback get_device(Config.t(), id, query) :: response
  @callback get_devices(Config.t(), query) :: response
  @callback set_device_location(Config.t(), id, id) :: response
  @callback update_device(Config.t(), id, attributes, relationships) :: response

  # Email Settings
  @callback update_account_email_settings(Config.t(), id, id, attributes) :: response

  # External Info
  @callback create_external_info(Config.t(), attributes, relationships) :: response
  @callback update_external_info(Config.t(), id, attributes) :: response
  @callback delete_external_info(Config.t(), id) :: response

  # Firmware
  @callback create_firmware(Config.t(), String.t()) :: response
  @callback delete_firmware(Config.t(), id) :: response
  @callback get_firmwares(Config.t()) :: response

  # Gateway
  @callback get_gateway(Config.t(), id, query) :: response
  @callback get_gateways(Config.t(), query) :: response
  @callback lock_gateway(Config.t(), id) :: response
  @callback restart_gateway(Config.t(), id) :: response
  @callback unlock_gateway(Config.t(), id, integer) :: response
  @callback update_gateway(Config.t(), id, attributes, relationships) :: response

  # Household
  @callback create_household(Config.t(), attributes, relationships) :: response
  @callback delete_household(Config.t(), id) :: response
  @callback get_household(Config.t(), id, query) :: response
  @callback get_households(Config.t(), query) :: response
  @callback update_household(Config.t(), id, attributes, relationships) :: response

  # Account invitation
  @callback create_account_invitation(Config.t(), id, attributes) :: response

  # KEM
  @callback upload_kem(Config.t(), list) :: response

  # Ping
  @callback ping(Config.t(), query) :: response

  # Property
  @callback create_property(Config.t(), attributes, relationships) :: response
  @callback delete_property(Config.t(), id) :: response
  @callback get_properties(Config.t(), query) :: response
  @callback get_property(Config.t(), id, query) :: response
  @callback update_property(Config.t(), id, attributes, relationships) :: response

  # Property Syncs
  @callback sync_property(Config.t(), id) :: response
  @callback create_synced_property_unik(Config.t(), unik_number, id) :: response

  # Report
  @callback get_device_reports(Config.t(), id) :: response
  @callback create_latest_report(Config.t(), id, query) :: response

  # Room
  @callback create_room(Config.t(), attributes, relationships) :: response
  @callback delete_room(Config.t(), id) :: response
  @callback get_room(Config.t(), id, query) :: response
  @callback get_rooms(Config.t(), query) :: response
  @callback update_room(Config.t(), id, attributes, relationships) :: response

  # Tenancy
  @callback create_tenancy(Config.t(), attributes, relationships) :: response
  @callback delete_tenancy(Config.t(), id) :: response
  @callback get_tenancy(Config.t(), id, query) :: response
  @callback update_tenancy(Config.t(), id, attributes) :: response

  # SIM
  @callback create_sim(Config.t(), attributes) :: response
  @callback delete_sim(Config.t(), id) :: response
  @callback get_sim(Config.t(), id, query) :: response
  @callback get_sims(Config.t(), query) :: response
  @callback update_sim(Config.t(), id, attributes) :: response

  # User
  @callback get_users(Config.t(), list) :: response

  # Wmbus Cache
  @callback get_wmbus_cache(Config.t(), id, query) :: response
  @callback refresh_wmbus_cache(Config.t(), id) :: response
end
