# Changelog for wise_homex

## 0.6.151 2024-11-07

* feat(api-client): add upload option for Lansen keys (#433)

## 0.6.150 2024-10-23

* feat(foreign-device): add assocs to room, heat source, and device (#432)

## 0.6.149 2024-09-25

* refactor(expenses) rename partial to needs_review

## 0.6.148 2024-09-06

* refactor(parsing json responses) support nil embeds
* feat(heat sources) add unknown radiator

## 0.6.147 2024-08-28

* feat(keepfocus-meter-importer): Add KeepFocus meter importer (#428)

## 0.6.146 2024-06-27

* build(dependencies): update Mix dependencies (#425)
* feat(distributed-expense): add partial field and nil expense type (#424)
* added vacancies to household
* feat(distributed_expense): add eed_including_online_usage_overview to types (#422)
* added support for properties/#{property.id}/reset
* feat(statement-config): add email notification option after approval (#419)
* change index to show action
* feat(PermanentAccountKey): add meter_data_provider field to model
* added measurements
* added treat_replaced_hcas_as_foreign to statemetnconfig
* remove unnecessary readme paragraph
* update deps
* add property relationships import request (#414)
* feat(wmbus): add support for retr. WMBus measurement modifications (#413)
* add delete tap shares for households in property (#412)
* update tap shares settlement values for all households in property (#411)
* feat: add custom name of tap place (#410)
* remove StatementChecks
* added job end-point
* add AccountPaymentImporter endpoint
* added household_sync_identifier
* add equal count for ready installations
* Added READy customers 
* allow ignoring certain types of foreign devices in statement config
* use Quantity master branch instead of hex.pm version
* support getting degree days for date range
* Support technician accesses
* add payments_last_synced_at to external tenancies
* add sync block field to external property
* add new statement config fields
* add two new fields to statement config
* GET /device-types
* removed flatrate from StatementConfig
* models/room: Add tap_places to Room
* json_parser: Add TapPlace to parser (special case)
* models: Add TapPlace
* endpoint for changing property admin
* device: has_one DSEnergyMeter
* Can split device
* Add support for add_encryption_key
* models: Add missing external_id:s
* add external_id to ExternalProperty
* add readonly field to PermanentAccountKey
* api_client: Support link/unlink and match DSEnergyLocations
* models: Add DSEnergyLocationMatch
* api_client_mock_server: Add support for failed calls
* Add support for DS Energy resources
* ready_meter: Rename two sync fields
* add account to permanent_account_key

## 0.6.145 2021-12-14

* models/pong: Add tag version
* Add telemetry for get,post,patch and delete

## 0.6.144 2021-12-07

* Can delete addresses
* Remove obsolete authorize device endpoints

## 0.6.143 2021-11-24

* Add has_many rooms to Household, 348

## 0.6.142 2021-10-29

* Add administrator field on Account, 345

## 0.6.141 2021-10-28

* Add encrypted field to devices

## 0.6.140 2021-10-27

* Remove set_device_location and unset_device_location, 344
* Remove room relation on UtilityReading, 343

## 0.6.139 2021-10-20

* Add Device.has_encryption_key field
* Update deps 20211013 (#341)
* Add support for PermanentAccountKeys

## 0.6.138 2021-09-15

* Add ReadyInstallation to Household, 338
* Remove firmware, 337

## 0.6.137 2021-09-06

* Add support for READy meters, 336

## 0.6.136 2021-08-25

* Improve feedback when no more mocks (issue #334), 335

## 0.6.135 2021-08-19

* Add READy installation link and matches, 333
* Update erlang 24.0.4 -> 24.0.5, 332
* Update ex_doc 0.25.0 -> 0.25.1, 332
* Added valid_sync_methods to ExternalProperty, 331

## 0.6.134 2021-08-03

* Added valid_sync_methods to ExternalProperty

## 0.6.133 2021-08-02

* Add serial connected devices, 330
* Add excluded fiscal years to household, 329

## 0.6.132 2021-07-28

* Add direct expense model and endpoints, 328

## 0.6.131 2021-07-28

* Add get_settlement_values, 327

## 0.6.130 2021-07-27

* New fields for heat and water meters, 326
* Update to erlang 24.0.4, elixir 1.12.2, 325
* Update ex_doc 0.24.2 -> 0.25.0, 325

## 0.6.129 2021-07-03

* Add auto_only field to StatementCheck

## 0.6.128 2021-07-01

* Added StatementCheck

## 0.6.127 2021-07-01

* Add deadline field to statement

## 0.6.126 2021-06-28

* Add models for READy groups, 320

## 0.6.125 2021-06-28

* Add attached to serial and number, 319

## 0.6.124 2021-06-24

* Add calculate missing readings, 318

## 0.6.123 2021-06-24

* Add sorting to StatementConfig, 317

## 0.6.122 2021-06-18

* Update erlang 24.0.1 -> 24.0.2, 316
* Update credo 1.5.5 -> 1.5.6, 316
* Add needs_review on HeatSource, 315
* Add external_resources on HeatSource, 314
* Update elixir 1.11.4 -> 1.12.1, 313
* Update ecto 3.6.1 -> 3.6.2, 313
* Restrict Github Actions permissions, 312

## 0.6.121 2021-05-25

* Add hot_water_heat_meter to ForeignDevice, 311

## 0.6.120 2021-05-18

* Move StatementConfig from Property to Statement, 310

## 0.6.119 2021-04-28

* Add distributed expense and endpoints, 306

## 0.6.118 2021-04-28

* Refactor to use q-prefix for account payments, 307
* Include skipped tests in CI, 304
* Update ecto 3.6.0 -> 3.6.1, 303
* Update ex_doc 0.24.1 -> 0.24.2, 303

## 0.6.117 2021-04-13

* Remove :enabled field on statement config model, 298

## 0.6.116 2021-04-12

* Add initally_locked_at to Statement model, 293
* Add statements_enabled to Property model, 292

## 0.6.115 2021-04-09

* Use quantity fields on Expense, 289
* Update dependencies, 291

## 0.6.114 2021-03-19

* Add supported fuel types for fuel check points, 288
* Update hackney 1.17.0 -> 1.17.3, 287
* Update ex_doc 0.23.0 -> 0.24.0, 287
* Update elixir 1.11.3 -> 1.11.4, 287

## 0.6.113 2021-03-17

* Remove default: [] from household remaining usage

## 0.6.112 2021-03-15

* Add :index for tenancies, 286
* Add remaining usage to household, 285
* Update erlang 23.2.6 -> 23.2.7, 284

## 0.6.111 2021-03-08

* Add fuel check points, #283
* Add q-values to expense, #282

## 0.6.110 2021-03-03

* Add installation details to property, 281

## 0.6.109 2021-02-23

* Add :calculation_method and :needs_review fields, 279
* Update ecto 3.5.7 -> 3.5.8, 277
* Update erlang 23.2.4 -> 23.2.5, 277
* Change actions/setup-elixir to erlef/setup-elixir, 276

## 0.6.108 2021-02-19

* Add :water_settlement_key to StatementConfig, 274

## 0.6.107 2021-02-19

* Add ExternalResource models and relations, 273
* Add statement_files, skip_moving_fee fields to Statement model, 273
* Update makeup_elixir 0.15.0 -> 0.15.1, 271
* Update ecto 3.5.6 -> 3.5.7, 271
* Update credo 1.5.4 -> 1.5.5, 271
* Update erlang 23.2.3 -> 23.2.4, 271

## 0.6.106 2021-02-12

* Add StatementFile model and endpoint, 270

## 0.6.105 2021-02-11

* Add external parts, remove external-infos, 268

## 0.6.104 2021-02-02

* Remove relation from :fiscal_year to :property, 266
* Update dependencies, 264

## 0.6.103 2021-01-27

* Add unsuccessful visits to Household, 263

## 0.6.102 2021-01-14

* Add radiator_string to Radiator, 261

## 0.6.101 2021-01-06

* Add last measurements to device, 259
* Add partial to expense, 257

## 0.6.100 2021-01-05

* Add published field to Property, 256
* Update hackney 1.16.0 -> 1.17.0 (and its deps), 258
* Update quantity 0.6.0 -> 0.6.1, 258
* Update credo 1.5.3 -> 1.5.4, 258
* Update erlang 23.2 -> 23.2.1, 258

## 0.6.99 2020-12-22

* Remove :installation_year from Device model, 252
* Add :snapshot_of, :snapshot, :active_from, :active_to fields to Property model, 254

## 0.6.98 2020-12-14

* Add :create, :delete, :update endpoints to heat sources, 249

## 0.6.97 2020-12-10

* Add devices to heat_source model, 247

## 0.6.96 2020-12-09

* Add active_from, active_to to HeatSource, 245
* Update earmark_parser 1.4.10 -> 1.4.12, 243
* Remove unused earmark dependency, 243

## 0.6.95 2020-12-03

* Add unmanaged field to Device
* Add support for UnsuccessfulVisit
* Update file_system 0.2.9 -> 0.2.10
* Update ecto 3.5.4 -> 3.5.5
* Update main.yml, README.md
* Update erlang 23.1.2 -> 23.1.4

## 0.6.94 2020-11-25

* Replace base_value, exponent, unit with value on Measurement model, 238

## 0.6.93 2020-11-24

* Add support for triggering a device re-balancing, 237

## 0.6.92 2020-11-24

* Add fields for shared household config, 236

## 0.6.91 2020-11-17

* Rename Measurement.value -> base_value, 234
* Use latest setup-elixir on v 1.x.x, 233

## 0.6.90 2020-10-20

* Remove duplicated docs, 229
* Update ex_doc 0.22.6 -> 0.23.0, 229
* Update ecto 3.5.0 -> 3.5.2, 229
* Update credo 1.4.0 -> 1.4.1, 229
* Update README.md, 229
* Update main.yml for GitHub Actions, 229
* Update elixir 1.10.4 -> 1.11.1, 229
* Update makeup_elixir 0.14.1 -> 0.15.0, 228
* Update makeup 1.0.4 -> 1.0.5, nimble_parsec 1.0.0 -> 1.1.0, 228
* Update ecto 3.4.6 -> 3.5.0, 228
* Update main.yml, README.md, 228
* Update erlang 23.1 -> 23.1.1, 228

## 0.6.89 2020-09-30

* Update Decimal to 2.0.0, 226

## 0.6.88 2020-09-16

* Rename require_customer_number -> require_customer_reference, 222

## 0.6.87 2020-09-16

* Add AdminData model, endpoints and behaviour, 220

## 0.6.86 2020-09-15

* Add :company_number to ExternalInfo, 219

## 0.6.85 2020-09-02

* Change tenancies -> tenancy on Account, 216

## 0.6.84 2020-08-20

* Add :enabled field on StatementConfig, 213

## 0.6.83 2020-08-18

* Add Vacancy, VacancyInfo and VacancyAccountPayment, 211

## 0.6.82 2020-07-08

* Added customer_reference to statement_config
* Update earmark 1.4.5 -> 1.4.7
* Update telemetry 0.4.1 -> 0.4.2
* Update httpoison 1.6.2 -> 1.7.0
* Update ecto 3.4.4 -> 3.4.5

## 0.6.81 2020-06-15

* Add zip_file_name to StatementZip, 204

## 0.6.80 2020-06-12

* Remove fast_ping endpoint, 199
* Add add_start_readings endpoint, 202

## 0.6.79 2020-05-27

* Add Foreign Devices, 197

## 0.6.78 2020-05-23

* taxable and excluded household fields
* Update elixir and erlang to OTP 23

## 0.6.77 2020-05-13

* Add fuel_type to Expense model, 193

## 0.6.76 2020-05-13

* Add messages to StatementConfig model, #191

## 0.6.75 2020-05-11

* Add pdf_naming_scheme to StatementConfig model, #189
* Update ecto 3.4.2 -> 3.4.3
* Update earmark 1.4.3 -> 1.4.4
* Update jason 1.2.0 -> 1.2.1
* Update erlang 22.3.2 -> 22.3.4
* Update credo 1.3.2 -> 1.4.0
* Update elixir 1.10.2 -> 1.10.3

## 0.6.74 2020-04-27

* Autocreate all endpoints that are not customized, #125

## 0.6.73 2020-04-16

* Add gateway activated field
* Remove heat source num_elements attribute

## 0.6.72 2020-04-03

* Add account_payment :update and missing behaviours, 178

## 0.6.71 2020-04-02

* Add converted_value to UtilityReading, 175
* Add excluded to AccountPayment, 177

## 0.6.70 2020-04-02

* Add heat_hca_ratio to StatementConfig, 173

## 0.6.69 2020-03-24

* Add support for StatementConfig, 169

## 0.6.68 2020-03-20

* Add support for angel note bunches, 167

## 0.6.67 2020-03-19

* Add endpoint for angel_notes :index, 163
* Support lists of values in URLs, 161

## 0.6.66 2020-03-18

* Add done_at to Statement model, 160

## 0.6.65 2020-03-17

* Add active_from, active_to on Device, 157

## 0.6.64 2020-03-11

* Add business field to household
* Update erlang 22.2.6 -> 22.2.8
* Update elixir 1.10.1 -> 1.10.2
* Update ecto 3.3.3 -> 3.3.4
* Update credo 1.2.2 -> 1.2.3

## 0.6.63 2020-02-24

* Use a map for holding entities in JSONParser to speed up parsing large requests, 152
* Update ecto 3.3.2 -> 3.3.3, 150

## 0.6.62 2020-02-13

* Add hot_water_heat_meter boolean to device, 148

## 0.6.61 2020-02-13

* Add exclude_from_statements to device, sort fields, 146
* Fix unrelated flickering test with MockServer, 147
* Updated mix.lock due to new hex version, 147

## 0.6.60 2020-02-12

* Handle if bad_gateway has a body
* Update erlang 22.2.5 -> 22.2.6
* Update elixir 1.10.0 -> 1.10.1

## 0.6.59 2020-02-04

* Add support for statement-zips
* Use latest setup-elixir action
* Update erlang 22.2.4 -> 22.2.5
* Update ex_doc 0.21.2 -> 0.21.3
* Update credo 1.2.1 -> 1.2.2

## 0.6.58

* Add support for Statement Data, 140

## 0.6.57 2020-01-29

* Move reduction factor, 133
* Update ecto 3.3.1 -> 3.3.2, 139
* Update credo 1.1.5 -> 1.2.1, 139
* Update erlang to 22.2.4, 139
* Update elixir 1.9.4 -> 1.10.0, 139

## 0.6.56 2020-01-29

* Rename WiseHomex.Quantity.Type -> WiseHomex.QuantityType for better compatability with Quantity, 134

## 0.6.55 2020-01-27

* Add support for Account Payments, 111
* Update erlang 22.2.2 -> 22.2.3, 132

## 0.6.54 2020-01-23

* Update Quantity 0.2.0 -> 0.3.0, 130
* Generate :fiscal_year endpoints, :firmware, :external_info, :devices, :angel_notes endpoints, 127
* Generate :admin_integration_unik, :admin_integration, :address, :account_user, :account endpoints automatically, 126

## 0.6.53 2020-01-20

* Update Quantity 0.1.0 -> 0.2.0, #123

## 0.6.52 2020-01-17

* Extract Quantity into separate library, 120

## 0.6.51 2020-01-10

* Add support for WMBusMessageInfo, WMBusMessageQuery, 113
* Add support for embeds_one and embeds_many, 117

## 0.6.50 2020-01-09

* Standalone API configuration in api_config.exs, 109
* Automatic registration of models and types in JSONParser, 114
* Add support for query on :create and :update, 119

## 0.6.49 2020-01-02

* Expenses and Automatic API client function generation, 107
* Update erlang 22.2 -> 22.2.1, 108
* Update ecto 3.3.0 -> 3.3.1, 108
* Update decimal 1.8.0 -> 1.8.1, 108

## 0.6.48 2019-12-18

* Add support for radiator info, 104

## 0.6.47 2019-12-16

* Add support for fiscal years, 102
* Update ecto 3.2.5 -> 3.3.0, 103
* Update nimble_parsec 0.5.2 -> 0.5.3, 103
* Update erlang 22.1.8 -> 22.2, 103

## 0.6.46 2019-12-12

* Add support for statements, 100

## 0.6.45 2019-11-26

* Add number to Tenancy and Household models, 98

## 0.6.44 2019-11-25

* Fix casting of PostalAddress, 95
* Update erlang 22.1.6 -> 22.1.8
* Update earmark 1.4.2 -> 1.4.3
* Update nimble_parsec 0.5.1 -> 0.5.2

## 0.6.43 2019-11-12

* Can delete account-users
* Update erlang 22.1.5 -> 22.1.6
* Update elixir 1.9.2 -> 1.9.4
* Update httpoison 1.6.1 -> 1.6.2
* Update ecto 3.2.3 -> 3.2.5

## 0.6.42 2019-11-06

* Added support for zip codes (#89)

## 0.6.41 2019-10-30

* Added count_updated field to RadiatorImportResult

## 0.6.40 2019-10-30

* Added archived_at field to Radiator model

## 0.6.39 2019-10-29

* Added new fields to heat source and radiator
* Update erlang 22.1.3 -> 22.1.4
* Update ecto 3.2.2 -> 3.2.3
* Faster json parsing

## 0.6.38 2019-10-23

* Support for getting heat sources from the API
* Update erlang 22.1.2 -> 22.1.3
* Update elixir 1.9.1 -> 1.9.2
* Update earmark 1.4.1 -> 1.4.2
* Cleanup credo config
* Update credo 1.1.4 -> 1.1.5

## 0.6.37 2019-10-10

* Added virtual field to household
* Update erlang 22.1.1 -> 22.1.2
* Update httpoison 1.6.0 -> 1.6.1

## 0.6.36 2019-10-08

* Respect timeout for get, patch and delete
* Handle timeout

## 0.6.35 2019-10-07

* Add postal_address to Property

## 0.6.34 2019-10-06

* Added postal_address and customer_number to accounts
* Update erlang 21.1 -> 21.1.1
* Update ecto 3.2.1 -> 3.2.2
* Update httpoison 1.5.1 -> 1.6.0
* Update hackney 1.15.1 -> 1.15.2, ssl_verify_fun 1.1.4 -> 1.1.5

## 0.6.33 2019-09-30

* Support for show and index radiators

## 0.6.32 2019-09-27

* Parse MessageReports with correct utc_datetimes, 72

## 0.6.31 2019-09-26

* Added support for radiator import
* Update dialyxir 0.5.1 -> 1.0.0-rc.7
* Update earmark 1.4.0 -> 1.4.1

## 0.6.30 2019-09-24

* Added support for import device endpoint.

## 0.6.29 2019-09-23

* Rename wmbus serials to number

## 0.6.28 2019-09-21

* Change interface of set_device_location

## 0.6.27 2019-09-19

* Can implicitly encode DateTime and Quantity in requests
* Get, create, update and delete utility readings
* Update ecto 3.2.0 -> 3.2.1
* Update erlang 22.0.7 -> 22.1
* Use default ecto format without parenthesis in schema spec, 57

## 0.6.26 2019-09-13

* Add get_utility_readings
* UtilityReading model
* Quantity
* Use a common test case for all tests
* Update earmark 1.3.6 -> 1.4.0
* Update ecto 3.1.7 -> 3.2.0

## 0.6.25 2019-09-06

* Can update address

## 0.6.24 2019-09-06

* 281de16 Can get_addresses
* 81f504c Update ex_doc 0.21.1 -> 0.21.2
* 0e80add Update earmark 1.3.5 -> 1.3.6
* c53e810 Update credo 1.1.3 -> 1.1.4

## 0.6.23 2019-09-02

* Add query to get_settlement_key to be able to include relations<Paste>

## 0.6.22 2019-08-29

* SettlementValue model and API functions
* SettlementKey model and api functions

## 0.6.21 2019-08-23

* Skip tests against Elixir 1.8 as we want ~U in tests
* Parses signal_strength_history as an embed
* Update credo 1.1.2 -> 1.1.3

## 0.6.20 2019-08-20

* Fix nil relationship parsing, 52
* Parses datetimes, 52
* Parses dates in json parser, 52
* Update ex_doc 0.19.3 -> 0.21.1 + nested deps
* Update credo 1.0.3 -> 1.1.2
* Update ecto 3.0.7 -> 3.1.7
* Update decimal 1.7.0 -> 1.8.0
* Update httpoison 1.5.0 -> 1.5.1

## 0.6.19 2019-08-13

* Added unconfigurable_reason to ConfigurableMeterID

## 0.6.18 2019-08-09

* Can unset device location
* Added legal_name attribute to property
* Added address place attribute
* CircleCI build script and tool-versions, 8
* Include company number as required attr in unic sync

## 0.6.17 2019-08-07

- Can reset a running mock server

## 0.6.16 2019-08-07

- Added child_spec for ApiClientMockServer

## 0.6.15 2019-06-18

- Include file_content for :create_firmware mock (https://github.com/wise-home/wise_homex/issues/40)

## 0.6.14 2019-06-17

- Add number field on Property model (https://github.com/wise-home/wise_homex/issues/38)

## 0.6.13 2019-06-07

- Add delete_gateway call (https://github.com/wise-home/wise_homex/issues/36)

## 0.6.12 2019-06-03

- Add last_synced_at field to ExternalInfo model (https://github.com/wise-home/wise_homex/issues/34)

## 0.6.11 2019-05-28

- Order all functions by functionality and then alphabetically (https://github.com/wise-home/wise_homex/issues/13)

## 0.6.10

- Set up multiple mocks in a single call (https://github.com/wise-home/wise_homex/issues/31)

## 0.6.9

- Add support for UNIK property synchronization (https://github.com/wise-home/wise_homex/issues/29)

## 0.6.8

- Add support for AdminIntegrations (https://github.com/wise-home/wise_homex/issues/25)

## 0.6.7

- Bugfix: ApiMockServer adds missing mocks to mock state bug (https://github.com/wise-home/wise_homex/issues/26)

## 0.6.6

- Add support for ExternalInfo (https://github.com/wise-home/wise_homex/issues/12)

## 0.6.5

- Add number to Device model (https://github.com/wise-home/wise_homex/issues/22)

## 0.6.4

- Include TenancyModelTest in WiseHomex (https://github.com/wise-home/wise_homex/issues/18)
- Better error responses for missing mocks (https://github.com/wise-home/wise_homex/issues/16)
- Remove defaults for 4 api calls (https://github.com/wise-home/wise_homex/issues/14)
- Fix three test issues (https://github.com/wise-home/wise_homex/issues/20)

## 0.6.3

- Add remaning_calls function helper for testing, https://github.com/wise-home/wise_homex/pull/11

## 0.6.2

- Add notes endpoint, https://github.com/wise-home/wise_homex/issues/9
- Cleanup: Make create_account, deauthorize_device, api_client functions one-liners

## 0.6.1

- Add the ability to make requests without authentication, https://github.com/wise-home/wise_homex/pull/7

## 0.6.0

- Initial release of the wise_homex api client, only for internal use at Wise Home.
