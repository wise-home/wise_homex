# Changelog for wise_homex

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
