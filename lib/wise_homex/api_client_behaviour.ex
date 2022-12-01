defmodule WiseHomex.ApiClientBehaviour do
  @moduledoc """
  Defines the callbacks in the WiseHomex.ApiClient to ensure consistency between
  the ApiClient implementation and the ApiClient Mock and possibly other implementations.
  """

  alias WiseHomex.Config

  @type response :: WiseHomex.ResponseParser.response() | :econnrefused | :connect_timeout | :timeout | :closed

  @type id :: String.t()
  @type unik_number :: pos_integer
  @type query :: map
  @type attributes :: map
  @type relationships :: map

  # Account
  @callback create_account(Config.t(), attributes, relationships, query) :: response
  @callback delete_account(Config.t(), id) :: response
  @callback get_account(Config.t(), id, query) :: response
  @callback get_accounts(Config.t(), query) :: response
  @callback update_account(Config.t(), id, attributes, relationships, query) :: response

  # Account Invitation
  @callback create_account_invitation(Config.t(), id, attributes) :: response

  # Account Payment
  @callback create_account_payment(Config.t(), attributes, relationships, query) :: response
  @callback delete_account_payment(Config.t(), id) :: response
  @callback get_account_payment(Config.t(), id, query) :: response
  @callback get_account_payments(Config.t(), query) :: response
  @callback update_account_payment(Config.t(), id, attributes, relationships, query) :: response

  # Account User
  @callback get_account_users(Config.t(), query) :: response
  @callback delete_account_user(Config.t(), id) :: response

  # Address
  @callback create_address(Config.t(), attributes, relationships, query) :: response
  @callback update_address(Config.t(), id, attributes, relationships, query) :: response
  @callback get_address(Config.t(), id, query) :: response
  @callback get_addresses(Config.t(), query) :: response
  @callback delete_address(Config.t(), id) :: response

  # Add start readings
  @callback add_start_readings(Config.t(), id) :: response

  # Admin Data
  @callback get_admin_data(Config.t(), id, query) :: response
  @callback update_admin_data(Config.t(), id, attributes, relationships, query) :: response

  # Admin Integration
  @callback delete_admin_integration(Config.t(), id) :: response
  @callback get_admin_integration(Config.t(), id, query) :: response
  @callback get_admin_integrations(Config.t(), query) :: response

  # Admin Integration UNIK
  @callback create_admin_integration_unik(Config.t(), attributes, relationships, query) :: response
  @callback update_admin_integration_unik(Config.t(), id, attributes, relationships, query) :: response

  # Angel Note
  @callback create_angel_note(Config.t(), attributes, relationships, query) :: response
  @callback delete_angel_note(Config.t(), id) :: response
  @callback get_angel_note(Config.t(), String.t(), id) :: response
  @callback update_angel_note(Config.t(), id, attributes, relationships, query) :: response

  # Angel Note Bunch
  @callback create_angel_note_bunch(Config.t(), attributes, relationships, query) :: response

  # Bmeters Keys
  @callback upload_bmeters_keys(Config.t(), list) :: response

  # Broken Account Payment
  @callback delete_broken_account_payment(Config.t(), id) :: response
  @callback get_broken_account_payment(Config.t(), id, query) :: response
  @callback get_broken_account_payments(Config.t(), query) :: response

  # Calculate missing readings
  @callback calculate_missing_readings(Config.t(), id) :: response

  # Device
  @callback create_device(Config.t(), attributes, relationships, query) :: response
  @callback delete_device(Config.t(), id) :: response
  @callback get_device(Config.t(), id, query) :: response
  @callback get_devices(Config.t(), query) :: response
  @callback update_device(Config.t(), id, attributes, relationships, query) :: response
  @callback import_devices(Config.t(), attributes, relationships) :: response
  @callback split_device(Config.t(), attributes, relationships) :: response
  @callback get_device_types(Config.t()) :: response
  @callback change_device_type(Config.t(), id, attributes) :: response

  # Device balancer
  @callback rebalance_devices(Config.t(), id) :: response

  # Direct Expenses
  @callback create_direct_expense(Config.t(), attributes, relationships, query) :: response
  @callback delete_direct_expense(Config.t(), id) :: response
  @callback get_direct_expense(Config.t(), id, query) :: response
  @callback get_direct_expenses(Config.t(), query) :: response
  @callback update_direct_expense(Config.t(), id, attributes, relationships, query) :: response

  # Distributed Expenses
  @callback create_distributed_expense(Config.t(), attributes, relationships, query) :: response
  @callback delete_distributed_expense(Config.t(), id) :: response
  @callback get_distributed_expense(Config.t(), id, query) :: response
  @callback update_distributed_expense(Config.t(), id, attributes, relationships, query) :: response

  # Email Settings
  @callback update_account_email_settings(Config.t(), id, id, attributes) :: response

  # External Households
  @callback get_external_households(Config.t(), query) :: response
  @callback get_external_household(Config.t(), id, query) :: response
  @callback create_external_household(Config.t(), attributes, relationships, query) :: response
  @callback update_external_household(Config.t(), id, attributes, relationships, query) :: response
  @callback delete_external_household(Config.t(), id) :: response

  # External Properties
  @callback get_external_properties(Config.t(), query) :: response
  @callback get_external_property(Config.t(), id, query) :: response
  @callback create_external_property(Config.t(), attributes, relationships, query) :: response
  @callback update_external_property(Config.t(), id, attributes, relationships, query) :: response
  @callback delete_external_property(Config.t(), id) :: response

  # External Resources
  @callback get_external_resources(Config.t(), query) :: response
  @callback get_external_resource(Config.t(), id, query) :: response
  @callback create_external_resource(Config.t(), attributes, relationships, query) :: response
  @callback update_external_resource(Config.t(), id, attributes, relationships, query) :: response
  @callback delete_external_resource(Config.t(), id) :: response

  # External Tenancies
  @callback get_external_tenancies(Config.t(), query) :: response
  @callback get_external_tenancy(Config.t(), id, query) :: response
  @callback create_external_tenancy(Config.t(), attributes, relationships, query) :: response
  @callback update_external_tenancy(Config.t(), id, attributes, relationships, query) :: response
  @callback delete_external_tenancy(Config.t(), id) :: response

  # External Vacancies
  @callback get_external_vacancies(Config.t(), query) :: response
  @callback get_external_vacancy(Config.t(), id, query) :: response
  @callback create_external_vacancy(Config.t(), attributes, relationships, query) :: response
  @callback update_external_vacancy(Config.t(), id, attributes, relationships, query) :: response
  @callback delete_external_vacancy(Config.t(), id) :: response

  # Expense
  @callback get_expenses(Config.t(), query) :: response
  @callback get_expense(Config.t(), id, query) :: response
  @callback create_expense(Config.t(), attributes, relationships, query) :: response
  @callback update_expense(Config.t(), id, attributes, relationships, query) :: response
  @callback delete_expense(Config.t(), id) :: response

  # Devices
  @callback add_encryption_key(Config.t(), id, query) :: response

  # Foreign Device
  @callback get_foreign_device(Config.t(), id, query) :: response
  @callback get_foreign_devices(Config.t(), query) :: response
  @callback create_foreign_device(Config.t(), attributes, relationships, query) :: response
  @callback update_foreign_device(Config.t(), id, attributes, relationships, query) :: response
  @callback delete_foreign_device(Config.t(), id) :: response

  # Fiscal Years
  @callback get_fiscal_years(Config.t(), query) :: response
  @callback get_fiscal_year(Config.t(), id, query) :: response
  @callback create_fiscal_year(Config.t(), attributes, relationships, query) :: response
  @callback update_fiscal_year(Config.t(), id, attributes, relationships, query) :: response
  @callback delete_fiscal_year(Config.t(), id) :: response

  # Fuel Check Point
  @callback get_fuel_check_point(Config.t(), id, query) :: response
  @callback get_fuel_check_points(Config.t(), query) :: response
  @callback create_fuel_check_point(Config.t(), attributes, relationships, query) :: response
  @callback update_fuel_check_point(Config.t(), id, attributes, relationships, query) :: response
  @callback delete_fuel_check_point(Config.t(), id) :: response

  # Gateway
  @callback get_gateway(Config.t(), id, query) :: response
  @callback get_gateways(Config.t(), query) :: response
  @callback delete_gateway(Config.t(), id) :: response
  @callback lock_gateway(Config.t(), id) :: response
  @callback restart_gateway(Config.t(), id) :: response
  @callback unlock_gateway(Config.t(), id, integer) :: response
  @callback update_gateway(Config.t(), id, attributes, relationships, query) :: response

  # HeatSource
  @callback create_heat_source(Config.t(), attributes, relationships, query) :: response
  @callback delete_heat_source(Config.t(), id) :: response
  @callback get_heat_source(Config.t(), id, query) :: response
  @callback get_heat_sources(Config.t(), query) :: response
  @callback update_heat_source(Config.t(), id, attributes, relationships, query) :: response

  # Household
  @callback create_household(Config.t(), attributes, relationships, query) :: response
  @callback delete_household(Config.t(), id) :: response
  @callback get_household(Config.t(), id, query) :: response
  @callback get_households(Config.t(), query) :: response
  @callback update_household(Config.t(), id, attributes, relationships, query) :: response

  # KEM uploads
  @callback upload_kem(Config.t(), list) :: response

  # Ping
  @callback ping(Config.t(), query) :: response

  # Property
  @callback create_property(Config.t(), attributes, relationships, query) :: response
  @callback delete_property(Config.t(), id) :: response
  @callback get_properties(Config.t(), query) :: response
  @callback get_property(Config.t(), id, query) :: response
  @callback update_property(Config.t(), id, attributes, relationships, query) :: response
  @callback property_change_admin(Config.t(), id, attributes, relationships, query) :: response

  # Property Syncs
  @callback sync_property(Config.t(), id) :: response

  # Property Syncs UNIK
  @callback create_synced_property_unik(Config.t(), unik_number, unik_number, id) :: response

  # Radiators
  @callback get_radiator(Config.t(), id, query) :: response
  @callback get_radiators(Config.t(), query) :: response
  @callback import_radiators(Config.t(), attributes) :: response

  # Radiator Info
  @callback get_radiator_info(Config.t(), id, query) :: response

  # READy Customers
  @callback get_ready_customer(Config.t(), id, query) :: response
  @callback get_ready_customers(Config.t(), query) :: response

  # READy Groups
  @callback get_ready_group(Config.t(), id, query) :: response
  @callback get_ready_groups(Config.t(), query) :: response
  @callback update_ready_group(Config.t(), id, attributes, relationships, query) :: response

  # READy Installation
  @callback get_ready_installations(Config.t(), query) :: response

  # READy Installation Matches
  @callback ready_installation_matches(Config.t(), relationships, query) :: response
  @callback ready_installation_already_matched(Config.t(), relationships, query) :: response
  @callback link_ready_installation_match(Config.t(), relationships, query) :: response
  @callback unlink_ready_installation_match(Config.t(), relationships, query) :: response

  # DS Energy
  @callback ds_energy_location_matches(Config.t(), relationships, query) :: response
  @callback ds_energy_location_already_matched(Config.t(), relationships, query) :: response
  @callback link_ds_energy_location_match(Config.t(), relationships, query) :: response
  @callback unlink_ds_energy_location_match(Config.t(), relationships, query) :: response

  # Reports
  @callback create_latest_report(Config.t(), id, query) :: response
  @callback get_device_reports(Config.t(), id) :: response

  # Room
  @callback create_room(Config.t(), attributes, relationships, query) :: response
  @callback delete_room(Config.t(), id) :: response
  @callback get_room(Config.t(), id, query) :: response
  @callback get_rooms(Config.t(), query) :: response
  @callback update_room(Config.t(), id, attributes, relationships, query) :: response

  # SettlementKey
  @callback get_settlement_key(Config.t(), id, query) :: response
  @callback get_settlement_keys(Config.t(), query) :: response
  @callback create_settlement_key(Config.t(), attributes, relationships, query) :: response
  @callback update_settlement_key(Config.t(), id, attributes, relationships, query) :: response
  @callback delete_settlement_key(Config.t(), id) :: response

  # SettlementValue
  @callback get_settlement_value(Config.t(), id, query) :: response
  @callback get_settlement_values(Config.t(), query) :: response
  @callback create_settlement_value(Config.t(), attributes, relationships, query) :: response
  @callback update_settlement_value(Config.t(), id, attributes, relationships, query) :: response
  @callback delete_settlement_value(Config.t(), id) :: response

  # SIM
  @callback create_sim(Config.t(), attributes, relationships, query) :: response
  @callback delete_sim(Config.t(), id) :: response
  @callback get_sim(Config.t(), id, query) :: response
  @callback get_sims(Config.t(), query) :: response
  @callback update_sim(Config.t(), id, attributes, relationships, query) :: response

  # Statement
  @callback get_statement(Config.t(), id, query) :: response
  @callback get_statements(Config.t(), query) :: response
  @callback create_statement(Config.t(), attributes, relationships, query) :: response
  @callback update_statement(Config.t(), id, attributes, relationships, query) :: response
  @callback delete_statement(Config.t(), id) :: response
  @callback create_next_statement(Config.t(), id, query) :: response

  # StatementConfig
  @callback get_statement_config(Config.t(), id, query) :: response
  @callback update_statement_config(Config.t(), id, attributes, relationships, query) :: response

  # StatementData
  @callback get_statement_data(Config.t(), id, query) :: response
  @callback create_statement_data(Config.t(), attributes, relationships, query) :: response

  # StatementFile
  @callback create_statement_file(Config.t(), attributes, relationships, query) :: response

  # StatementZip
  @callback create_statement_zip(Config.t(), attributes, relationships, query) :: response

  # Tenancy
  @callback get_tenancy(Config.t(), id, query) :: response
  @callback get_tenancies(Config.t(), query) :: response
  @callback create_tenancy(Config.t(), attributes, relationships, query) :: response
  @callback delete_tenancy(Config.t(), id) :: response
  @callback update_tenancy(Config.t(), id, attributes, relationships, query) :: response

  # User
  @callback get_users(Config.t(), query) :: response

  # UtilityReading
  @callback get_utility_reading(Config.t(), id, query) :: response
  @callback get_utility_readings(Config.t(), query) :: response
  @callback create_utility_reading(Config.t(), attributes, relationships, query) :: response
  @callback update_utility_reading(Config.t(), id, attributes, relationships, query) :: response
  @callback delete_utility_reading(Config.t(), id) :: response

  # Account Payment
  @callback update_vacancy_account_payment(Config.t(), id, attributes, relationships, query) :: response

  # Wmbus Cache
  @callback get_wmbus_cache(Config.t(), id, query) :: response
  @callback refresh_wmbus_cache(Config.t(), id) :: response

  # Zip codes
  @callback get_zip_codes(Config.t(), query) :: response
end
