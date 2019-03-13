defmodule WiseHomex.ApiClientBehaviour do
  @moduledoc """
  Defines the callbacks in the WiseHomex.ApiClient to ensure consistency between
  the ApiClient implementation and the ApiClient Mock and possibly other implementations.
  """

  alias WiseHomex.Config

  @type response ::
          WiseHomex.ResponseParser.response() | :econnrefused | :connect_timeout | :closed

  @type id :: binary
  @type query :: map
  @type attributes :: map
  @type relationships :: map

  @callback create_account(Config.t(), attributes, relationships) :: response
  @callback delete_account(Config.t(), id) :: response
  @callback get_account(Config.t(), id, query) :: response
  @callback get_accounts(Config.t(), query) :: response
  @callback update_account(Config.t(), id, attributes) :: response
  @callback get_account_users(Config.t(), query) :: response
  @callback create_address(Config.t(), attributes, relationships) :: response
  @callback get_address(Config.t(), id, query) :: response
  @callback upload_bmeters_keys(Config.t(), list) :: response
  @callback add_device(Config.t(), id, binary, binary) :: response
  @callback authorize_device(Config.t(), id) :: response
  @callback deauthorize_device(Config.t(), id) :: response
  @callback delete_device(Config.t(), id) :: response
  @callback fast_ping_device(Config.t(), id) :: response
  @callback get_device(Config.t(), id, query) :: response
  @callback get_devices(Config.t(), query) :: response
  @callback set_device_location(Config.t(), id, id) :: response
  @callback update_device(Config.t(), id, attributes, relationships) :: response
  @callback update_account_email_settings(Config.t(), id, id, attributes) :: response
  @callback create_firmware(Config.t(), binary) :: response
  @callback delete_firmware(Config.t(), id) :: response
  @callback get_firmwares(Config.t()) :: response
  @callback get_gateway(Config.t(), id, query) :: response
  @callback get_gateways(Config.t(), query) :: response
  @callback lock_gateway(Config.t(), id) :: response
  @callback restart_gateway(Config.t(), id) :: response
  @callback unlock_gateway(Config.t(), id, integer) :: response
  @callback update_gateway(Config.t(), id, attributes, relationships) :: response
  @callback create_household(Config.t(), attributes, relationships) :: response
  @callback delete_household(Config.t(), id) :: response
  @callback get_household(Config.t(), id, query) :: response
  @callback get_households(Config.t(), query) :: response
  @callback update_household(Config.t(), id, attributes, relationships) :: response
  @callback create_account_invitation(Config.t(), id, attributes) :: response
  @callback upload_kem(Config.t(), list) :: response
  @callback ping(Config.t(), query) :: response
  @callback create_property(Config.t(), attributes, relationships) :: response
  @callback delete_property(Config.t(), id) :: response
  @callback get_properties(Config.t(), query) :: response
  @callback get_property(Config.t(), id, query) :: response
  @callback update_property(Config.t(), id, attributes, relationships) :: response
  @callback get_device_reports(Config.t(), id) :: response
  @callback create_latest_report(Config.t(), id, query) :: response
  @callback create_room(Config.t(), attributes, relationships) :: response
  @callback delete_room(Config.t(), id) :: response
  @callback get_room(Config.t(), id, query) :: response
  @callback get_rooms(Config.t(), query) :: response
  @callback update_room(Config.t(), id, attributes, relationships) :: response
  @callback create_tenancy(Config.t(), attributes, relationships) :: response
  @callback delete_tenancy(Config.t(), id) :: response
  @callback get_tenancy(Config.t(), id, query) :: response
  @callback update_tenancy(Config.t(), id, attributes) :: response
  @callback create_sim(Config.t(), attributes) :: response
  @callback delete_sim(Config.t(), id) :: response
  @callback get_sim(Config.t(), id, query) :: response
  @callback get_sims(Config.t(), query) :: response
  @callback update_sim(Config.t(), id, attributes) :: response
  @callback get_users(Config.t(), list) :: response
  @callback get_wmbus_cache(Config.t(), id, query) :: response
  @callback refresh_wmbus_cache(Config.t(), id) :: response
end
