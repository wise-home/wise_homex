defmodule WiseHomex.Test.ApiClientMock do
  @moduledoc """
  Implementation of all functions for the ApiClient Mock.
  Before using this Mock, remember to start the mock server
  """

  @behaviour WiseHomex.ApiClientBehaviour

  import WiseHomex.Test.ApiClientMockServer, only: [call_and_get_mock_value: 2]

  # Account
  def create_account(_config, attrs, rels) do
    call_and_get_mock_value(:create_account, %{attrs: attrs, rels: rels})
  end

  def delete_account(_config, id) do
    call_and_get_mock_value(:delete_account, %{id: id})
  end

  def get_account(_config, id, query) do
    call_and_get_mock_value(:get_account, %{id: id, query: query})
  end

  def get_accounts(_config, query) do
    call_and_get_mock_value(:get_accounts, %{query: query})
  end

  def update_account(_config, id, attrs) do
    call_and_get_mock_value(:update_account, %{id: id, attrs: attrs})
  end

  # Account User
  def get_account_users(_config, query) do
    call_and_get_mock_value(:get_account_users, %{query: query})
  end

  # Address
  def create_address(_config, attrs, rels) do
    call_and_get_mock_value(:create_address, %{attrs: attrs, rels: rels})
  end

  def update_address(_config, id, attrs) do
    call_and_get_mock_value(:update_address, %{id: id, attrs: attrs})
  end

  def get_address(_config, id, query) do
    call_and_get_mock_value(:get_address, %{id: id, query: query})
  end

  def get_addresses(_config, query \\ %{}) do
    call_and_get_mock_value(:get_addresses, %{query: query})
  end

  # Admin Integration
  def get_admin_integrations(_config, query \\ %{}) do
    call_and_get_mock_value(:get_admin_integrations, %{query: query})
  end

  def get_admin_integration(_config, id, query \\ %{}) do
    call_and_get_mock_value(:get_admin_integration, %{id: id, query: query})
  end

  def delete_admin_integration(_config, id) do
    call_and_get_mock_value(:delete_admin_integration, %{id: id})
  end

  # Admin Integration UNIK
  def create_admin_integration_unik(_config, attrs, rels) do
    call_and_get_mock_value(:create_admin_integration_unik, %{attrs: attrs, rels: rels})
  end

  def update_admin_integration_unik(_config, id, attrs) do
    call_and_get_mock_value(:update_admin_integration_unik, %{id: id, attrs: attrs})
  end

  # Angel Note
  def get_angel_note(_config, target_type, target_id) do
    call_and_get_mock_value(:get_angel_note, %{target_type: target_type, target_id: target_id})
  end

  def create_angel_note(_config, attrs) do
    call_and_get_mock_value(:create_angel_note, %{attrs: attrs})
  end

  def update_angel_note(_config, id, attrs) do
    call_and_get_mock_value(:update_angel_note, %{id: id, attrs: attrs})
  end

  def delete_angel_note(_config, id) do
    call_and_get_mock_value(:delete_angel_note, %{id: id})
  end

  # Bmeters Keys
  def upload_bmeters_keys(_config, opts) do
    call_and_get_mock_value(:upload_bmeters_keys, %{opts: opts})
  end

  # Device
  def add_device(_config, gateway_id, protocol, serial) do
    call_and_get_mock_value(:add_device, %{
      gateway_id: gateway_id,
      protocol: protocol,
      serial: serial
    })
  end

  def authorize_device(_config, device_id) do
    call_and_get_mock_value(:authorize_device, %{device_id: device_id})
  end

  def deauthorize_device(_config, device_id) do
    call_and_get_mock_value(:deauthorize_device, %{device_id: device_id})
  end

  def delete_device(_config, id) do
    call_and_get_mock_value(:delete_device, %{id: id})
  end

  def fast_ping_device(_config, id) do
    call_and_get_mock_value(:fast_ping_device, %{id: id})
  end

  def get_device(_config, id, query) do
    call_and_get_mock_value(:get_device, %{id: id, query: query})
  end

  def get_devices(_config, query) do
    call_and_get_mock_value(:get_devices, %{query: query})
  end

  def set_device_location(_config, device_id, attrs, rels) do
    call_and_get_mock_value(:set_device_location, %{device_id: device_id, attrs: attrs, rels: rels})
  end

  def unset_device_location(_config, device_id) do
    call_and_get_mock_value(:unset_device_location, %{device_id: device_id})
  end

  def update_device(_config, id, attrs, rels) do
    call_and_get_mock_value(:update_device, %{id: id, attrs: attrs, rels: rels})
  end

  def import_devices(_config, attrs, rels) do
    call_and_get_mock_value(:import_devices, %{attrs: attrs, rels: rels})
  end

  # Email Settings
  def update_account_email_settings(_config, account_id, id, attrs) do
    call_and_get_mock_value(:update_account_email_settings, %{
      id: id,
      account_id: account_id,
      attrs: attrs
    })
  end

  # External Info
  def create_external_info(_config, attrs, rels) do
    call_and_get_mock_value(:create_external_info, %{attrs: attrs, rels: rels})
  end

  def update_external_info(_config, id, attrs) do
    call_and_get_mock_value(:update_external_info, %{id: id, attrs: attrs})
  end

  def delete_external_info(_config, id) do
    call_and_get_mock_value(:delete_external_info, %{id: id})
  end

  # Firmware
  def create_firmware(_config, file_content) do
    call_and_get_mock_value(:create_firmware, %{file_content: file_content})
  end

  def delete_firmware(_config, id) do
    call_and_get_mock_value(:delete_firmware, %{id: id})
  end

  def get_firmwares(_config) do
    call_and_get_mock_value(:get_firmwares, %{})
  end

  # Gateway
  def get_gateway(_config, id, query) do
    call_and_get_mock_value(:get_gateway, %{id: id, query: query})
  end

  def get_gateways(_config, query) do
    call_and_get_mock_value(:get_gateways, %{query: query})
  end

  def delete_gateway(_config, id) do
    call_and_get_mock_value(:delete_gateway, %{id: id})
  end

  def lock_gateway(_config, id) do
    call_and_get_mock_value(:lock_gateway, %{id: id})
  end

  def restart_gateway(_config, id) do
    call_and_get_mock_value(:restart_gateway, %{id: id})
  end

  def unlock_gateway(_config, id, seconds) do
    call_and_get_mock_value(:unlock_gateway, %{id: id, seconds: seconds})
  end

  def update_gateway(_config, id, attrs, rels) do
    call_and_get_mock_value(:update_gateway, %{id: id, attrs: attrs, rels: rels})
  end

  # Household
  def create_household(_config, attrs, rels) do
    call_and_get_mock_value(:create_household, %{attrs: attrs, rels: rels})
  end

  def delete_household(_config, id) do
    call_and_get_mock_value(:delete_household, %{id: id})
  end

  def get_household(_config, id, query) do
    call_and_get_mock_value(:get_household, %{id: id, query: query})
  end

  def get_households(_config, query) do
    call_and_get_mock_value(:get_households, %{query: query})
  end

  def update_household(_config, id, attrs, rels) do
    call_and_get_mock_value(:update_household, %{id: id, attrs: attrs, rels: rels})
  end

  # Account invitation
  def create_account_invitation(_config, account_id, attrs) do
    call_and_get_mock_value(:create_account_invitation, %{account_id: account_id, attrs: attrs})
  end

  # KEM uploads
  def upload_kem(_config, opts) do
    call_and_get_mock_value(:upload_kem, %{opts: opts})
  end

  # Ping
  def ping(_config, query) do
    call_and_get_mock_value(:ping, %{query: query})
  end

  # Property
  def create_property(_config, attrs, rels) do
    call_and_get_mock_value(:create_property, %{attrs: attrs, rels: rels})
  end

  def delete_property(_config, id) do
    call_and_get_mock_value(:delete_property, %{id: id})
  end

  def get_properties(_config, query) do
    call_and_get_mock_value(:get_properties, %{query: query})
  end

  def get_property(_config, id, query) do
    call_and_get_mock_value(:get_property, %{id: id, query: query})
  end

  def update_property(_config, id, attrs, rels) do
    call_and_get_mock_value(:update_property, %{id: id, attrs: attrs, rels: rels})
  end

  # Property Syncs
  def sync_property(_config, property_id) do
    call_and_get_mock_value(:sync_property, %{property_id: property_id})
  end

  # Property Syncs UNIK
  def create_synced_property_unik(_config, property_number, company_number, admin_id) do
    call_and_get_mock_value(:create_synced_property_unik, %{
      property_number: property_number,
      company_number: company_number,
      admin_id: admin_id
    })
  end

  # Reports
  def get_device_reports(_config, id) do
    call_and_get_mock_value(:get_device_reports, %{id: id})
  end

  def create_latest_report(_config, device_id, query) do
    call_and_get_mock_value(:create_latest_report, %{device_id: device_id, query: query})
  end

  # Room
  def create_room(_config, attrs, rels) do
    call_and_get_mock_value(:create_room, %{attrs: attrs, rels: rels})
  end

  def delete_room(_config, id) do
    call_and_get_mock_value(:delete_room, %{id: id})
  end

  def get_room(_config, id, query) do
    call_and_get_mock_value(:get_room, %{id: id, query: query})
  end

  def get_rooms(_config, query) do
    call_and_get_mock_value(:get_rooms, %{query: query})
  end

  def update_room(_config, id, attrs, rels) do
    call_and_get_mock_value(:update_room, %{id: id, attrs: attrs, rels: rels})
  end

  # Tenancy
  def create_tenancy(_config, attrs, rels) do
    call_and_get_mock_value(:create_tenancy, %{attrs: attrs, rels: rels})
  end

  def delete_tenancy(_config, id) do
    call_and_get_mock_value(:delete_tenancy, %{id: id})
  end

  def get_tenancy(_config, id, query) do
    call_and_get_mock_value(:get_tenancy, %{id: id, query: query})
  end

  def update_tenancy(_config, id, attrs) do
    call_and_get_mock_value(:update_tenancy, %{id: id, attrs: attrs})
  end

  # SettlementKey
  def get_settlement_key(_config, id, query \\ %{}) do
    call_and_get_mock_value(:get_settlement_key, %{id: id, query: query})
  end

  def get_settlement_keys(_config, query) do
    call_and_get_mock_value(:get_settlement_keys, %{query: query})
  end

  def create_settlement_key(_config, attrs, rels) do
    call_and_get_mock_value(:create_settlement_key, %{attrs: attrs, rels: rels})
  end

  def update_settlement_key(_config, id, attrs) do
    call_and_get_mock_value(:update_settlement_key, %{id: id, attrs: attrs})
  end

  def delete_settlement_key(_config, id) do
    call_and_get_mock_value(:delete_settlement_key, %{id: id})
  end

  # SettlementKey
  def get_settlement_value(_config, id, query \\ %{}) do
    call_and_get_mock_value(:get_settlement_value, %{id: id, query: query})
  end

  def create_settlement_value(_config, attrs, rels) do
    call_and_get_mock_value(:create_settlement_value, %{attrs: attrs, rels: rels})
  end

  def update_settlement_value(_config, id, attrs) do
    call_and_get_mock_value(:update_settlement_value, %{id: id, attrs: attrs})
  end

  def delete_settlement_value(_config, id) do
    call_and_get_mock_value(:delete_settlement_value, %{id: id})
  end

  # SIM
  def create_sim(_config, attrs) do
    call_and_get_mock_value(:create_sim, %{attrs: attrs})
  end

  def delete_sim(_config, id) do
    call_and_get_mock_value(:delete_sim, %{id: id})
  end

  def get_sim(_config, id, query) do
    call_and_get_mock_value(:get_sim, %{id: id, query: query})
  end

  def get_sims(_config, query) do
    call_and_get_mock_value(:get_sims, %{query: query})
  end

  def update_sim(_config, id, attrs) do
    call_and_get_mock_value(:update_sim, %{id: id, attrs: attrs})
  end

  # User
  def get_users(_config, filters \\ []) do
    call_and_get_mock_value(:get_users, %{filters: filters})
  end

  # UtilityReading
  def get_utility_reading(_config, id, query \\ %{}) do
    call_and_get_mock_value(:get_utility_reading, %{id: id, query: query})
  end

  def get_utility_readings(_config, query \\ %{}) do
    call_and_get_mock_value(:get_utility_readings, %{query: query})
  end

  def create_utility_reading(_config, attrs, rels) do
    call_and_get_mock_value(:create_utility_reading, %{attrs: attrs, rels: rels})
  end

  def update_utility_reading(_config, id, attrs, rels) do
    call_and_get_mock_value(:update_utility_reading, %{id: id, attrs: attrs, rels: rels})
  end

  def delete_utility_reading(_config, id) do
    call_and_get_mock_value(:delete_utility_reading, %{id: id})
  end

  # Wmbus Cache
  def get_wmbus_cache(_config, gateway_id, query) do
    call_and_get_mock_value(:get_wmbus_cache, %{gateway_id: gateway_id, query: query})
  end

  def refresh_wmbus_cache(_config, gateway_id) do
    call_and_get_mock_value(:refresh_wmbus_cache, %{gateway_id: gateway_id})
  end
end
