defmodule WiseHomex.JSONParserTest do
  use WiseHomex.Test.Case, async: true

  alias WiseHomex.Account
  alias WiseHomex.Device
  alias WiseHomex.DeviceAuthorization
  alias WiseHomex.Household
  alias WiseHomex.JSONParser
  alias WiseHomex.PostalAddress
  alias WiseHomex.Room

  test "can parse json body to entities" do
    result =
      """
      {
        "data": [
          {
            "attributes": {
              "api-key": "somekey"
            },
            "id": "8",
            "relationships": {
              "account": {
                "data": {
                  "id": "6",
                  "type": "accounts"
                }
              },
              "user": {
                "data": {
                  "id": "8",
                  "type": "users"
                }
              }
            },
            "type": "account-users"
          },
          {
            "attributes": {
              "api-key": "somekey"
            },
            "id": "9",
            "relationships": {
              "account": {
                "data": {
                  "id": "7",
                  "type": "accounts"
                }
              },
              "user": {
                "data": {
                  "id": "8",
                  "type": "users"
                }
              }
            },
            "type": "account-users"
          }
        ],
        "included": [
          {
            "attributes": {
              "name": "The Tenant",
              "role": "tenant"
            },
            "id": "6",
            "type": "accounts"
          },
          {
            "attributes": {
              "name": "Admin Adminson",
              "role": "admin"
            },
            "id": "7",
            "type": "accounts"
          },
          {
            "attributes": {
              "email": "some-mail@some-mail.com"
            },
            "id": "8",
            "type": "users"
          }
        ],
        "jsonapi": {
          "version": "1.0"
        }
      }
      """
      |> Jason.decode!()
      |> JSONParser.parse()

    [first, _] = result
    assert first.account.id == "6"
    assert first.user.id == "8"
    assert first.user_id == "8"
  end

  test "can read relationship data from main data" do
    # This happens when the related model is already included in the main data,
    # e.g. when getting list of accounts and both an account and it's owner
    # account is included in the list.
    result =
      """
      {
        "data": [
          {
            "attributes": {
              "name": "The Tenant",
              "role": "tenant"
            },
            "id": "6",
            "relationships": {
              "owner": {
                "data": null
              }
            },
            "type": "accounts"
          },
          {
            "attributes": {
              "name": "Admin Adminson",
              "role": "admin"
            },
            "id": "7",
            "relationships": {
              "owner": {
                "data": null
              }
            },
            "type": "accounts"
          },
          {
            "attributes": {
              "name": "Tenant Tentson",
              "role": "tenant"
            },
            "id": "8",
            "relationships": {
              "owner": {
                "data": {
                  "id": "7",
                  "type": "accounts"
                }
              }
            },
            "type": "accounts"
          }
        ],
        "jsonapi": {
          "version": "1.0"
        }
      }
      """
      |> Jason.decode!()
      |> JSONParser.parse()

    [_angel, _admin, _tenant] = result
  end

  test "reading relationships that are lists" do
    report =
      """
      {
        "jsonapi": {
          "version": "1.0"
        },
        "included": [
          {
            "type": "devices",
            "id": "1",
            "attributes": {
              "serial": "1234123412341234",
              "location": "Kitchen",
              "inserted-at": "2016-11-24T14:37:06",
              "authorized-at": "2016-11-24T14:37:06"
            }
          },
          {
            "type": "measurements",
            "id": "1",
            "attributes": {
              "value": 5600,
              "unit": "percent",
              "meter-type": "humidity",
              "measurement-at": "2016-11-24T14:37:06",
              "location": null,
              "exponent": -2
            }
          }
        ],
        "data": {
          "type": "latest-reports",
          "relationships": {
            "measurements": {
              "data": [
                {
                  "type": "measurements",
                  "id": "1"
                }
              ]
            },
            "device": {
              "data": {
                "type": "devices",
                "id": "1"
              }
            }
          },
          "id": "",
          "attributes": {}
        }
      }
      """
      |> Jason.decode!()
      |> JSONParser.parse()

    assert [%WiseHomex.Measurement{}] = report.measurements
  end

  test "reading relationships from included entities" do
    # A device with a room with a household
    parsed_response =
      """
      {
        "jsonapi": {
          "version": "1.0"
        },
        "included": [
          {
            "type": "gateways",
            "id": "1",
            "attributes": {
              "serial": "1234123412341234",
              "location": "Basement",
              "last-connect-at": null,
              "address": "My Street 5\\n1234 My City"
            }
          },
          {
            "type": "households",
            "id": "1",
            "attributes": {
              "apartment": "10. th."
            }
          },
          {
            "type": "rooms",
            "relationships": {
              "household": {
                "data": {
                  "type": "households",
                  "id": "1"
                }
              }
            },
            "id": "2",
            "attributes": {
              "u-value": null,
              "name": "Living room"
            }
          }
        ],
        "data": {
          "type": "devices",
          "relationships": {
            "room": {
              "data": {
                "type": "rooms",
                "id": "2"
              }
            },
            "gateway": {
              "data": {
                "type": "gateways",
                "id": "1"
              }
            }
          },
          "id": "2",
          "attributes": {
            "serial": "1234123412341234",
            "online": "no",
            "location": null,
            "last-seen": null,
            "inserted-at": "2016-12-06T13:03:24",
            "device-type": "humidity sensor",
            "authorized-at": null
          }
        }
      }
      """
      |> Jason.decode!()
      |> JSONParser.parse()

    %Device{room: %Room{household: %Household{} = household}} = parsed_response

    assert household.apartment == "10. th."
  end

  test "handling recursive structures" do
    example_response =
      """
      {
        "jsonapi": {
          "version": "1.0"
        },
        "data": {
          "type": "accounts",
          "relationships": {
            "owner": {
              "data": {
                "type": "accounts",
                "id": "1"
              }
            }
          },
          "id": "1",
          "attributes": {
            "name": "Self-owned"
          }
        }
      }
      """
      |> Jason.decode!()

    %Account{} = JSONParser.parse(example_response)
  end

  test "parsing device-authorization" do
    parsed_response =
      """
      {
        "jsonapi": {
          "version": "1.0"
        },
        "included": [
          {
            "type": "devices",
            "id": "2",
            "attributes": {
              "serial": "1234123412341234",
              "inserted-at": "2016-12-09T09:21:29",
              "authorized-at": "2016-12-09T21:18:32"
            }
          }
        ],
        "data": {
          "type": "device-authorizations",
          "relationships": {
            "device": {
              "data": {
                "type": "devices",
                "id": "2"
              }
            }
          },
          "id": "",
          "attributes": {}
        }
      }
      """
      |> Jason.decode!()
      |> JSONParser.parse()

    %DeviceAuthorization{} = auth = parsed_response

    assert auth.device.id == "2"
    assert auth.device_id == "2"
  end

  test "skipping unknown fields" do
    response =
      """
      {
        "data": {
          "type": "devices",
          "id": "1",
          "attributes": {
            "serial": "myserial",
            "unknownfield": "foo"
          }
        }
      }
      """
      |> Jason.decode!()
      |> JSONParser.parse()

    %Device{} = device = response

    assert device.serial == "myserial"
    refute Map.has_key?(device, :unknownfield)
  end

  test "skipping unknown relation" do
    parsed_response =
      """
      {
        "data": {
          "type": "devices",
          "id": "1",
          "attributes": {
            "serial": "serial 1"
          },
          "relationships": {
            "foobar": {"data": {"type": "devices", "id": "2"}}
          }
        },
        "included": [
          {
            "type": "devices",
            "id": "2",
            "attributes": {
              "serial": "serial 2"
            }
          }
        ]
      }
      """
      |> Jason.decode!()
      |> JSONParser.parse()

    %Device{} = device = parsed_response

    assert device.serial == "serial 1"
    refute Map.has_key?(device, :foobar)
  end

  test "skipping unknown relation type" do
    example_response =
      """
      {
        "data": {
          "type": "devices",
          "id": "1",
          "attributes": {
            "serial": "serial 1"
          },
          "relationships": {
            "foobar": {"data": {"type": "foobar", "id": "1"}}
          }
        },
        "included": [
          {
            "type": "foobar",
            "id": "1",
            "attributes": {
              "baz": "FOO"
            }
          }
        ]
      }
      """
      |> Jason.decode!()

    %Device{} = device = JSONParser.parse(example_response)

    assert device.serial == "serial 1"
    refute Map.has_key?(device, :foobar)
  end

  test "parsing deeply nested structure" do
    parsed_response =
      """
      {
        "data": {
          "attributes": {
            "city": "Nyby",
            "property": "Nyvej 123",
            "zip-code": "1234"
          },
          "id": "12341234123412341234123412341234123433",
          "relationships": {
            "addresses": {
              "data": [
                {
                  "id": "ABCDEF",
                  "type": "addresses"
                }
              ]
            }
          },
          "type": "properties"
        },
        "included": [
          {
            "attributes": {
              "street_and_number": "Gakvej 19",
              "zip_code": "9999",
              "city": "The City",
              "country_code_alpha3": "DNK"
            },
            "id": "ABCDEF",
            "relationships": {
              "households": {
                "data": [
                  {
                    "id": "1000",
                    "type": "households"
                  }
                ]
              }
            },
            "type": "addresses"
          },
          {
            "attributes": {
              "apartment": "20. tv."
            },
            "id": "1000",
            "relationships": {
              "tenant": {
                "data": null
              }
            },
            "type": "households"
          }
        ],
        "jsonapi": {
          "version": "1.0"
        }
      }
      """
      |> Jason.decode!()
      |> JSONParser.parse()

    assert parsed_response.addresses |> hd |> Map.get(:households) |> hd |> Map.get(:apartment) ==
             "20. tv."
  end

  test "parsing relation that is not included" do
    household =
      """
      {
        "data": {
          "id": "1",
          "relationships": {
            "tenant": {
              "data": {
                "id": "200",
                "type": "users"
              }
            }
          },
          "type": "households"
        }
      }
      """
      |> Jason.decode!()
      |> JSONParser.parse()

    assert household.tenant_id == "200"
  end

  test "circular reference" do
    # Here the nested household has a relation to the top most property
    property =
      """
      {
        "data": {
          "attributes": {
            "name": "My fine property"
          },
          "id": "9999",
          "relationships": {
            "admin": {
              "data": {
                "id": "2",
                "type": "accounts"
              }
            },
            "addresses": {
              "data": [
                {
                  "id": "2000",
                  "type": "addresses"
                }
              ]
            }
          },
          "type": "properties"
        },
        "included": [
          {
            "attributes": {
              "email": null,
              "name": "Admin Adminson",
              "phone": null,
              "role": "admin"
            },
            "id": "2",
            "type": "accounts"
          },
          {
            "attributes": {
              "city": "Nyby",
              "street_and_number": "Fine Street 49",
              "property": "Nyvej 125",
              "zip-code": "1234"
            },
            "id": "2000",
            "relationships": {
              "admin": {
                "data": {
                  "id": "2",
                  "type": "accounts"
                }
              },
              "property": {
                "data": {
                  "id": "9999",
                  "type": "properties"
                }
              },
              "tenant": {
                "data": null
              }
            },
            "type": "addresses"
          }
        ],
        "jsonapi": {
          "version": "1.0"
        }
      }
      """
      |> Jason.decode!()
      |> JSONParser.parse()

    assert property.addresses |> length == 1
  end

  test "skips unknown empty has-many relation" do
    account =
      """
      {
        "data": {
          "id": "1",
          "relationships": {
            "foos": {
              "data": []
            }
          },
          "type": "accounts"
        }
      }
      """
      |> Jason.decode!()
      |> JSONParser.parse()

    assert account.id == "1"
  end

  test "parse dates as Date" do
    json = """
    {
      "data": {
        "type": "tenancies",
        "id": "a2d75bd4-c0a8-4316-8592-df4ac86774b8",
        "attributes": {
          "move-in-date": "2019-08-19"
        }
      }
    }
    """

    tenancy =
      json
      |> Jason.decode!()
      |> JSONParser.parse()

    assert tenancy.move_in_date == ~D[2019-08-19]
  end

  test "parse datetimes as DateTime" do
    data = %{
      "data" => %{
        "type" => "users",
        "id" => "45",
        "attributes" => %{
          "activated-at" => "2019-08-19T15:28:00.000000Z"
        }
      }
    }

    user = JSONParser.parse(data)

    assert user.activated_at == ~U[2019-08-19 15:28:00Z]
  end

  test "sets relations to nil if they are nil" do
    data = %{
      "data" => %{
        "type" => "households",
        "id" => "1",
        "relationships" => %{
          "tenant" => %{"data" => nil}
        }
      }
    }

    household = JSONParser.parse(data)
    assert household.tenant == nil
  end

  test "parsing embed" do
    data = %{
      "data" => %{
        "type" => "devices",
        "id" => "1",
        "attributes" => %{
          "signal-strength-history" => [
            %{"time" => "2019-08-21T23:58:00Z", "signal-strength" => -88},
            %{"time" => "2019-08-21T23:59:00Z", "signal-strength" => -87}
          ]
        }
      }
    }

    device = JSONParser.parse(data)

    assert device.signal_strength_history == [
             %Device.Signal{time: ~U[2019-08-21 23:58:00Z], signal_strength: -88},
             %Device.Signal{time: ~U[2019-08-21 23:59:00Z], signal_strength: -87}
           ]
  end

  test "parsing MessageReport" do
    data = %{
      "data" => [
        %{
          "attributes" => %{
            "events" => [
              ["Waiting for device to become responsive", "2019-09-27T20:14:23.942737Z"]
            ],
            "name" => "Fast ping",
            "started-at" => "2019-09-27T20:14:23.942389Z",
            "stopped-at" => "2019-09-27T20:23:53.450495Z"
          },
          "id" => "",
          "type" => "message-reports"
        }
      ],
      "jsonapi" => %{"version" => "1.0"}
    }

    [report] = JSONParser.parse(data)

    [event] = report.events
    assert event.description == "Waiting for device to become responsive"
    assert event.time == ~U[2019-09-27 20:14:23Z]
    assert report.name == "Fast ping"
    assert report.started_at == ~U[2019-09-27 20:14:23Z]
    assert report.stopped_at == ~U[2019-09-27 20:23:53Z]
  end

  test "parse custom ecto type PostalAddress" do
    data = %{
      "data" => %{
        "type" => "accounts",
        "id" => "9",
        "attributes" => %{
          "postal-address" => %{
            "address" => "Storegade 42",
            "city" => "Aarhus C",
            "country-code-alpha3" => "DNK",
            "zip-code" => "8000"
          }
        }
      }
    }

    account = JSONParser.parse(data)
    assert account.postal_address == PostalAddress.new("Storegade 42", "8000", "Aarhus C", "DNK")
  end

  test "parse custom ecto type DecimalType" do
    data = %{
      "data" => %{
        "type" => "devices",
        "id" => "9",
        "attributes" => %{
          "reduction-factor" => "1.10"
        }
      }
    }

    device = JSONParser.parse(data)
    assert device.reduction_factor == ~d[1.10]
  end

  test "parse embeds that are normal ecto schemas" do
    data = %{
      "data" => %{
        "attributes" => %{"save" => true, "timeout" => 30_000},
        "id" => "",
        "relationships" => %{
          "devices" => %{"data" => [%{"id" => "8350", "type" => "devices"}, %{"id" => "8351", "type" => "devices"}]},
          "gateway" => %{"data" => %{"id" => "2389", "type" => "gateways"}},
          "wmbus-message-infos" => %{
            "data" => [
              %{"id" => "286dbd35-93da-4926-b927-5a2202b9e350", "type" => "wmbus-message-infos"},
              %{"id" => "a961b901-092e-4bb0-9c35-5a04fef2c888", "type" => "wmbus-message-infos"}
            ]
          }
        },
        "type" => "wmbus-message-queries"
      },
      "included" => [
        %{
          "attributes" => %{
            "address" => nil,
            "enabled-modules" => [],
            "last-connect-at" => "2020-01-09T13:06:14Z",
            "location" => nil,
            "notes" => nil,
            "online" => "no",
            "postal-address" => nil,
            "serial" => "0200000100003A7C",
            "skip-offline-report" => false,
            "software-version" => "balrog 1.2.3",
            "unlocked-at" => "2020-01-09T13:06:14Z",
            "unlocked-seconds" => 60
          },
          "id" => "2389",
          "relationships" => %{"admin" => %{"data" => nil}, "sim" => %{"data" => nil}},
          "type" => "gateways"
        },
        %{
          "attributes" => %{
            "authorized-at" => nil,
            "inserted-at" => "2020-01-09T13:06:14Z",
            "installation-year" => 2019,
            "last-seen" => nil,
            "number" => "00000107",
            "online" => "no",
            "protocol" => "wmbus",
            "reduction-factor" => "1",
            "serial" => "070100002D2C3004",
            "signal-strength" => nil,
            "signal-strength-history" => []
          },
          "id" => "8350",
          "relationships" => %{
            "device-type" => %{"data" => %{"id" => "4", "type" => "device-types"}},
            "gateway" => %{"data" => nil},
            "heat-source" => %{"data" => nil},
            "room" => %{"data" => nil}
          },
          "type" => "devices"
        },
        %{
          "attributes" => %{
            "authorized-at" => nil,
            "inserted-at" => "2020-01-09T13:06:14Z",
            "installation-year" => 2019,
            "last-seen" => nil,
            "number" => "00000108",
            "online" => "no",
            "protocol" => "wmbus",
            "reduction-factor" => "1",
            "serial" => "080100002D2C3004",
            "signal-strength" => nil,
            "signal-strength-history" => []
          },
          "id" => "8351",
          "relationships" => %{
            "device-type" => %{"data" => %{"id" => "4", "type" => "device-types"}},
            "gateway" => %{"data" => nil},
            "heat-source" => %{"data" => nil},
            "room" => %{"data" => nil}
          },
          "type" => "devices"
        },
        %{
          "attributes" => %{"signal-strength" => -40, "time" => "2020-01-09T13:06:14.492626Z"},
          "id" => "286dbd35-93da-4926-b927-5a2202b9e350",
          "relationships" => %{"device" => %{"data" => %{"id" => "8350", "type" => "devices"}}},
          "type" => "wmbus-message-infos"
        },
        %{
          "attributes" => %{"signal-strength" => -40, "time" => "2020-01-09T13:06:14.493500Z"},
          "id" => "a961b901-092e-4bb0-9c35-5a04fef2c888",
          "relationships" => %{"device" => %{"data" => %{"id" => "8351", "type" => "devices"}}},
          "type" => "wmbus-message-infos"
        }
      ],
      "jsonapi" => %{"version" => "1.0"}
    }

    wmbus_message_query = JSONParser.parse(data)
    assert wmbus_message_query.devices |> length() == 2
    assert wmbus_message_query.gateway
    assert wmbus_message_query.gateway_id == "2389"
    assert wmbus_message_query.wmbus_message_infos |> length() == 2
  end

  test "parse embeds that are not included" do
    data = %{
      "data" => %{
        "attributes" => %{"save" => true, "timeout" => 30_000},
        "id" => "",
        "relationships" => %{
          "gateway" => %{"data" => %{"id" => "7", "type" => "gateways"}}
        },
        "type" => "wmbus-message-queries"
      },
      "jsonapi" => %{"version" => "1.0"}
    }

    wmbus_message_query = JSONParser.parse(data)
    assert wmbus_message_query.devices |> length() == 0
    assert wmbus_message_query.gateway_id == "7"
    assert wmbus_message_query.wmbus_message_infos |> length() == 0
  end
end
