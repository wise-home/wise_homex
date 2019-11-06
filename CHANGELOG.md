# Changelog for wise_homex

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
