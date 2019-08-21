defmodule WiseHomex.JSONParserTest do
  use ExUnit.Case, async: true

  alias WiseHomex.Account
  alias WiseHomex.Device
  alias WiseHomex.DeviceAuthorization
  alias WiseHomex.Household
  alias WiseHomex.JSONParser
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

    assert user.activated_at == ~N[2019-08-19 15:28:00] |> DateTime.from_naive!("Etc/UTC")
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
end
