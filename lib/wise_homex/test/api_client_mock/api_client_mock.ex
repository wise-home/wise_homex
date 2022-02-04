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

  # Add start readings
  def add_start_readings(_config, statement_id) do
    call_and_get_mock_value(:add_start_readings, %{statement_id: statement_id})
  end

  # Angel Note
  def get_angel_note(_config, target_type, target_id) do
    call_and_get_mock_value(:get_angel_note, %{target_type: target_type, target_id: target_id})
  end

  # Bmeters Keys
  def upload_bmeters_keys(_config, opts) do
    call_and_get_mock_value(:upload_bmeters_keys, %{opts: opts})
  end

  # Calculate missing readings
  def calculate_missing_readings(_config, statement_id) do
    call_and_get_mock_value(:calculate_missing_readings, %{statement_id: statement_id})
  end

  # Device
  def import_devices(_config, attrs, rels) do
    call_and_get_mock_value(:import_devices, %{attrs: attrs, rels: rels})
  end

  # Device Balancer
  def rebalance_devices(_config, admin_id) do
    call_and_get_mock_value(:rebalance_devices, %{admin_id: admin_id})
  end

  # Email Settings
  def update_account_email_settings(_config, account_id, id, attrs) do
    call_and_get_mock_value(:update_account_email_settings, %{
      id: id,
      account_id: account_id,
      attrs: attrs
    })
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

  # READy
  def ready_installation_matches(_config, relationships, query) do
    call_and_get_mock_value(:ready_installation_matches, %{relationships: relationships, query: query})
  end

  def ready_installation_already_matched(_config, relationships, query) do
    call_and_get_mock_value(:ready_installation_already_matched, %{relationships: relationships, query: query})
  end

  def link_ready_installation_match(_config, relationships, query) do
    call_and_get_mock_value(:link_ready_installation_match, %{relationships: relationships, query: query})
  end

  def unlink_ready_installation_match(_config, relationships, query) do
    call_and_get_mock_value(:unlink_ready_installation_match, %{relationships: relationships, query: query})
  end

  # DS Energy
  def ds_energy_location_matches(_config, relationships, query) do
    call_and_get_mock_value(:ds_energy_location_matches, %{relationships: relationships, query: query})
  end

  def ds_energy_location_already_matched(_config, relationships, query) do
    call_and_get_mock_value(:ds_energy_location_already_matched, %{relationships: relationships, query: query})
  end

  def link_ds_energy_location_match(_config, relationships, query) do
    call_and_get_mock_value(:link_ds_energy_location_match, %{relationships: relationships, query: query})
  end

  def unlink_ds_energy_location_match(_config, relationships, query) do
    call_and_get_mock_value(:unlink_ds_energy_location_match, %{relationships: relationships, query: query})
  end

  # Reports
  def get_device_reports(_config, id) do
    call_and_get_mock_value(:get_device_reports, %{id: id})
  end

  def create_latest_report(_config, device_id, query) do
    call_and_get_mock_value(:create_latest_report, %{device_id: device_id, query: query})
  end

  # Statement
  def create_next_statement(_config, prev_statement_id, query) do
    call_and_get_mock_value(:create_next_statement, %{prev_statement_id: prev_statement_id, query: query})
  end

  # Wmbus Cache
  def get_wmbus_cache(_config, gateway_id, query) do
    call_and_get_mock_value(:get_wmbus_cache, %{gateway_id: gateway_id, query: query})
  end

  def refresh_wmbus_cache(_config, gateway_id) do
    call_and_get_mock_value(:refresh_wmbus_cache, %{gateway_id: gateway_id})
  end
end
