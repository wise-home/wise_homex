defmodule WiseHomex.Test.ApiClientMock do
  @moduledoc """
  Implementation of all functions for the ApiClient Mock.
  Before using this Mock, remember to start the mock server
  """

  @behaviour WiseHomex.ApiClientBehaviour

  import WiseHomex.Test.ApiClientMockServer, only: [call_and_get_mock_value: 2]

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

  def get_account_users(_config, query) do
    call_and_get_mock_value(:get_account_users, %{query: query})
  end

  def create_address(_config, attrs, rels) do
    call_and_get_mock_value(:create_address, %{attrs: attrs, rels: rels})
  end

  def get_address(_config, id, query) do
    call_and_get_mock_value(:get_address, %{id: id, query: query})
  end

  def upload_bmeters_keys(_config, opts) do
    call_and_get_mock_value(:upload_bmeters_keys, %{opts: opts})
  end

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

  def set_device_location(_config, device_id, room_id) do
    call_and_get_mock_value(:set_device_location, %{device_id: device_id, room_id: room_id})
  end

  def update_device(_config, id, attrs, rels) do
    call_and_get_mock_value(:update_device, %{id: id, attrs: attrs, rels: rels})
  end

  def update_account_email_settings(_config, account_id, id, attrs) do
    call_and_get_mock_value(:update_account_email_settings, %{
      id: id,
      account_id: account_id,
      attrs: attrs
    })
  end

  def create_firmware(_config, _file_content) do
    call_and_get_mock_value(:create_firmware, %{})
  end

  def delete_firmware(_config, id) do
    call_and_get_mock_value(:delete_firmware, %{id: id})
  end

  def get_firmwares(_config) do
    call_and_get_mock_value(:get_firmwares, %{})
  end

  def get_gateway(_config, id, query) do
    call_and_get_mock_value(:get_gateway, %{id: id, query: query})
  end

  def get_gateways(_config, query) do
    call_and_get_mock_value(:get_gateways, %{query: query})
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

  def create_account_invitation(_config, account_id, attrs) do
    call_and_get_mock_value(:create_account_invitation, %{account_id: account_id, attrs: attrs})
  end

  def upload_kem(_config, opts) do
    call_and_get_mock_value(:upload_kem, %{opts: opts})
  end

  def ping(_config, query) do
    call_and_get_mock_value(:ping, %{query: query})
  end

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

  def get_device_reports(_config, id) do
    call_and_get_mock_value(:get_device_reports, %{id: id})
  end

  def create_latest_report(_config, device_id, query) do
    call_and_get_mock_value(:create_latest_report, %{device_id: device_id, query: query})
  end

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

  def get_users(_config, filters \\ []) do
    call_and_get_mock_value(:get_users, %{filters: filters})
  end

  def get_wmbus_cache(_config, gateway_id, query) do
    call_and_get_mock_value(:get_wmbus_cache, %{gateway_id: gateway_id, query: query})
  end

  def refresh_wmbus_cache(_config, gateway_id) do
    call_and_get_mock_value(:refresh_wmbus_cache, %{gateway_id: gateway_id})
  end
end
