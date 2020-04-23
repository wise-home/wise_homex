defmodule WiseHomex.Test.ApiClientMock do
  @moduledoc """
  Implementation of all functions for the ApiClient Mock.
  Before using this Mock, remember to start the mock server
  """

  @behaviour WiseHomex.ApiClientBehaviour

  use WiseHomex.Test.ApiClientMock.Creator

  import WiseHomex.Test.ApiClientMockServer, only: [call_and_get_mock_value: 2]

  # Account invitation
  def create_account_invitation(_config, account_id, attrs) do
    call_and_get_mock_value(:create_account_invitation, %{account_id: account_id, attrs: attrs})
  end

  # Angel Note
  def get_angel_note(_config, target_type, target_id) do
    call_and_get_mock_value(:get_angel_note, %{target_type: target_type, target_id: target_id})
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

  def fast_ping_device(_config, id) do
    call_and_get_mock_value(:fast_ping_device, %{id: id})
  end

  def set_device_location(_config, device_id, attrs, rels) do
    call_and_get_mock_value(:set_device_location, %{device_id: device_id, attrs: attrs, rels: rels})
  end

  def unset_device_location(_config, device_id) do
    call_and_get_mock_value(:unset_device_location, %{device_id: device_id})
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

  # Firmware
  def create_firmware(_config, file_content) do
    call_and_get_mock_value(:create_firmware, %{file_content: file_content})
  end

  # Gateway
  def lock_gateway(_config, id) do
    call_and_get_mock_value(:lock_gateway, %{id: id})
  end

  def restart_gateway(_config, id) do
    call_and_get_mock_value(:restart_gateway, %{id: id})
  end

  def unlock_gateway(_config, id, seconds) do
    call_and_get_mock_value(:unlock_gateway, %{id: id, seconds: seconds})
  end

  # KEM uploads
  def upload_kem(_config, opts) do
    call_and_get_mock_value(:upload_kem, %{opts: opts})
  end

  # Ping
  def ping(_config, query) do
    call_and_get_mock_value(:ping, %{query: query})
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

  # Radiator
  def import_radiators(_config, attrs) do
    call_and_get_mock_value(:import_radiators, %{attrs: attrs})
  end

  # Reports
  def get_device_reports(_config, id) do
    call_and_get_mock_value(:get_device_reports, %{id: id})
  end

  def create_latest_report(_config, device_id, query) do
    call_and_get_mock_value(:create_latest_report, %{device_id: device_id, query: query})
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

  # Statement
  def get_statement(_config, id, query \\ %{}) do
    call_and_get_mock_value(:get_statement, %{id: id, query: query})
  end

  def get_statements(_config, query \\ %{}) do
    call_and_get_mock_value(:get_statements, %{query: query})
  end

  def create_statement(_config, attrs, rels) do
    call_and_get_mock_value(:create_statement, %{attrs: attrs, rels: rels})
  end

  def update_statement(_config, id, attrs) do
    call_and_get_mock_value(:update_statement, %{id: id, attrs: attrs})
  end

  def delete_statement(_config, id) do
    call_and_get_mock_value(:delete_statement, %{id: id})
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

  def get_zip_codes(_config) do
    call_and_get_mock_value(:get_zip_codes, %{})
  end
end
