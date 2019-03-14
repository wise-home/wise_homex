defmodule WiseHomex.ApiClient do
  @moduledoc """
  The Wise Home Api Client.

  Requires an implementation to be used. This will be read at runtime and default
  to WiseHomex.Http. Any implementation must implement WiseHomex.ApiClient.Behaviour.
  An alternative is WiseHomex.Test.Mock which can be used to test the client.
  """

  alias WiseHomex.Config

  @type response ::
          WiseHomex.ResponseParser.response() | :econnrefused | :connect_timeout | :closed

  defmodule Behaviour do
    @moduledoc """
    Defines the Behaviour for any implementation that is used for
    this ApiClient module.
    """

    @callback get(Config.t(), String.t(), any) :: any
    @callback post(Config.t(), String.t(), any) :: any
    @callback patch(Config.t(), String.t(), any) :: any
    @callback delete(Config.t(), String.t()) :: any
  end

  # Dynamically get the http implementation to use on runtime.
  defp client() do
    Application.get_env(:wise_homex, :client, WiseHomex.HTTP)
  end

  def ping(config, query) do
    client().get(config, "/ping", query)
  end

  def get_account_users(config, query) do
    client().get(config, "/account-users", query)
  end

  def get_accounts(config, query \\ %{}) do
    client().get(config, "/accounts", query)
  end

  def get_account(config, id, query \\ %{}) do
    client().get(config, "/accounts/" <> id, query)
  end

  def update_account(config, id, attrs) do
    payload =
      %{
        data: %{
          type: "accounts",
          id: id,
          attributes: attrs
        }
      }
      |> normalize_payload

    client().patch(config, "/accounts/" <> id, payload)
  end

  def update_account_email_settings(config, account_id, id, attrs) do
    payload =
      %{
        data: %{
          type: "account-email-settings",
          id: id,
          attributes: attrs
        }
      }
      |> normalize_payload

    client().patch(config, "/accounts/" <> account_id <> "/email-settings", payload)
  end

  def create_account_invitation(config, account_id, attrs) do
    payload =
      %{
        data: %{
          type: "account-invitations",
          attributes: attrs
        }
      }
      |> normalize_payload

    client().post(config, "/accounts/" <> account_id <> "/invitations", payload)
  end

  def delete_account(config, id) do
    client().delete(config, "/accounts/" <> id)
  end

  def create_account(config, attributes, rels) do
    Map.put_new(attributes, :owner_id, nil)

    params =
      %{
        data: %{
          type: "accounts",
          attributes: attributes,
          relationships: rels
        }
      }
      |> normalize_payload

    client().post(config, "/accounts", params)
  end

  def get_gateways(config, query \\ %{}) do
    query =
      %{"sort" => "-id"}
      |> Map.merge(query)

    client().get(config, "/gateways", query)
  end

  def get_gateway(config, id, query \\ %{}) do
    client().get(config, "/gateways/" <> id, query)
  end

  def update_gateway(config, id, attrs, rels \\ %{}) do
    payload =
      %{
        data: %{
          type: "gateways",
          id: id,
          attributes: attrs,
          relationships: rels
        }
      }
      |> normalize_payload

    client().patch(config, "/gateways/" <> id, payload)
  end

  def unlock_gateway(config, id, seconds) do
    payload =
      %{
        data: %{
          type: "gateway-unlocks",
          attributes: %{
            unlocked_seconds: seconds
          }
        }
      }
      |> normalize_payload

    client().post(config, "/gateways/" <> id <> "/unlocks", payload)
  end

  def lock_gateway(config, id) do
    payload =
      %{
        data: %{
          type: "gateway-locks"
        }
      }
      |> normalize_payload

    client().post(config, "/gateways/" <> id <> "/locks", payload)
  end

  def restart_gateway(config, id) do
    payload =
      %{
        data: %{
          type: "gateway-restarts"
        }
      }
      |> normalize_payload

    client().post(config, "/gateways/" <> id <> "/restarts", payload)
  end

  def get_wmbus_cache(config, gateway_id, query \\ %{}) do
    client().get(config, "/gateways/" <> gateway_id <> "/wmbus-meters/cache", query)
  end

  def refresh_wmbus_cache(config, gateway_id) do
    client().post(config, "/gateways/" <> gateway_id <> "/wmbus-meters/cache")
  end

  def get_devices(config, query \\ %{}) do
    query =
      %{"sort" => "-id"}
      |> Map.merge(query)

    client().get(config, "/devices", query)
  end

  def get_device(config, id, query \\ %{}) do
    client().get(config, "/devices/" <> id, query)
  end

  def update_device(config, id, attrs, rels) do
    params =
      %{
        data: %{
          type: "devices",
          id: id,
          attributes: attrs,
          relationships: rels
        }
      }
      |> normalize_payload

    client().patch(config, "/devices/" <> id, params)
  end

  def set_device_location(config, device_id, room_id) do
    payload =
      %{
        data: %{
          type: "device-locations",
          relationships: %{
            room: %{data: %{type: "rooms", id: room_id}}
          }
        }
      }
      |> normalize_payload()

    client().post(config, "/devices/" <> device_id <> "/location", payload)
  end

  def add_device(config, gateway_id, protocol, serial) do
    payload =
      %{
        "data" => %{
          "type" => "devices",
          "attributes" => %{
            "serial" => serial,
            "protocol" => protocol
          },
          "relationships" => %{
            "gateway" => %{"data" => %{"type" => "gateways", "id" => gateway_id}}
          }
        }
      }
      |> normalize_payload()

    client().post(config, "/devices", payload)
  end

  def delete_device(config, id) do
    client().delete(config, "/devices/" <> id)
  end

  def fast_ping_device(config, id) do
    params =
      %{
        data: %{
          type: "device-fast-pings"
        }
      }
      |> normalize_payload

    client().post(config, "/devices/" <> id <> "/fast-pings", params)
  end

  def get_device_reports(config, id) do
    client().get(config, "/devices/" <> id <> "/reports")
  end

  def get_households(config, query \\ %{}) do
    query =
      %{"sort" => "-id"}
      |> Map.merge(query)

    client().get(config, "/households", query)
  end

  def get_household(config, id, query \\ %{}) do
    client().get(config, "/households/" <> id, query)
  end

  def create_household(config, attrs, rels) do
    params =
      %{
        data: %{
          type: "households",
          attributes: attrs,
          relationships: rels
        }
      }
      |> normalize_payload

    client().post(config, "/households", params)
  end

  def update_household(config, id, attrs, rels) do
    params =
      %{
        data: %{
          type: "households",
          id: id,
          attributes: attrs,
          relationships: rels
        }
      }
      |> normalize_payload

    client().patch(config, "/households/" <> id, params)
  end

  def delete_household(config, id) do
    client().delete(config, "/households/" <> id)
  end

  def authorize_device(config, device_id) do
    client().post(config, "/devices/" <> device_id <> "/authorizations")
  end

  def deauthorize_device(config, device_id) do
    client().delete(config, "/devices/" <> device_id <> "/authorizations")
  end

  def get_users(config, filters \\ []) do
    query =
      filters
      |> Enum.map(fn {key, value} ->
        "filter[#{key}]=#{value}"
      end)
      |> Enum.join("&")

    query = if query == "", do: query, else: "?#{query}"
    client().get(config, "/users#{query}")
  end

  def get_firmwares(config) do
    client().get(config, "/firmwares", %{"page[size]" => 500})
  end

  def create_firmware(config, file_content) do
    payload = %{
      data: %{
        type: "firmwares",
        attributes: %{
          content_base64: file_content |> Base.encode64()
        }
      }
    }

    client().post(config, "/firmwares", payload)
  end

  def delete_firmware(config, id) do
    client().delete(config, "/firmwares/" <> id)
  end

  def create_latest_report(config, device_id, query \\ %{}) do
    payload = %{
      data: %{
        type: "latest-reports",
        relationships: %{
          device: %{data: %{type: "devices", id: device_id}}
        }
      }
    }

    client().post(config, "/reports/latest", query, payload)
  end

  def get_rooms(config, query) do
    client().get(config, "/rooms", query)
  end

  def get_room(config, id, query \\ %{}) do
    client().get(config, "/rooms/" <> id, query)
  end

  def create_room(config, attrs, rels) do
    params = %{
      data: %{
        type: "rooms",
        attributes: attrs,
        relationships: rels
      }
    }

    client().post(config, "/rooms", params)
  end

  def update_room(config, id, attrs, rels) do
    payload =
      %{
        data: %{
          type: "rooms",
          id: id,
          attributes: attrs,
          relationships: rels
        }
      }
      |> normalize_payload

    client().patch(config, "/rooms/" <> id, payload)
  end

  def delete_room(config, id) do
    client().delete(config, "/rooms/" <> id)
  end

  def get_properties(config, query \\ %{}) do
    client().get(config, "/properties", query)
  end

  def get_property(config, id, query \\ %{}) do
    client().get(config, "/properties/" <> id, query)
  end

  def create_property(config, attrs, rels) do
    params =
      %{
        data: %{
          type: "properties",
          attributes: attrs,
          relationships: rels
        }
      }
      |> normalize_payload

    client().post(config, "/properties", params)
  end

  def update_property(config, id, attrs, rels) do
    params =
      %{
        data: %{
          type: "properties",
          id: id,
          attributes: attrs,
          relationships: rels
        }
      }
      |> normalize_payload

    client().patch(config, "/properties/" <> id, params)
  end

  def delete_property(config, id) do
    client().delete(config, "/properties/" <> id)
  end

  def get_address(config, id, query \\ %{}) do
    client().get(config, "/addresses/" <> id, query)
  end

  def create_address(config, attrs, rels) do
    params =
      %{
        data: %{
          type: "addresses",
          attributes: attrs,
          relationships: rels
        }
      }
      |> normalize_payload

    client().post(config, "/addresses", params)
  end

  def get_tenancy(config, id, query \\ %{}) do
    client().get(config, "/tenancies/" <> id, query)
  end

  def create_tenancy(config, attrs, rels) do
    params =
      %{
        data: %{
          type: "tenancies",
          attributes: attrs,
          relationships: rels
        }
      }
      |> normalize_payload

    client().post(config, "/tenancies", params)
  end

  def update_tenancy(config, id, attrs) do
    payload =
      %{
        data: %{
          type: "tenancies",
          id: id,
          attributes: attrs
        }
      }
      |> normalize_payload

    client().patch(config, "/tenancies/" <> id, payload)
  end

  def delete_tenancy(config, id) do
    client().delete(config, "/tenancies/" <> id)
  end

  def get_sims(config, query \\ %{}) do
    default_query = %{"page[size]" => 500}
    query = Map.merge(default_query, query)
    client().get(config, "/sims", query)
  end

  def get_sim(config, id, query \\ %{}) do
    client().get(config, "/sims/" <> id, query)
  end

  def create_sim(config, attrs) do
    payload =
      %{
        data: %{
          type: "sims",
          attributes: attrs
        }
      }
      |> normalize_payload

    client().post(config, "/sims", payload)
  end

  def update_sim(config, id, attrs) do
    payload =
      %{
        data: %{
          type: "sims",
          id: id,
          attributes: attrs
        }
      }
      |> normalize_payload

    client().patch(config, "/sims/" <> id, payload)
  end

  def delete_sim(config, id) do
    client().delete(config, "/sims/" <> id)
  end

  def upload_kem(config, file_base64: file_base64, key: key) do
    payload =
      %{
        data: %{
          type: "kems",
          attributes: %{
            file_base64: file_base64,
            key: key
          }
        }
      }
      |> normalize_payload

    # Use a longer timeout for the request since it may take a long time
    config
    |> Map.update!(:timeout, fn _ -> 60_000 end)
    |> client().post("/kamstrup/kems", payload)
  end

  def upload_bmeters_keys(config, file_base64: file_base64) do
    payload =
      %{
        data: %{
          type: "encryption-keys",
          attributes: %{
            file_base64: file_base64
          }
        }
      }
      |> normalize_payload

    client().post(config, "/bmeters/keys", payload)
  end

  defp normalize_payload(%{} = payload) do
    payload
    |> Enum.into(%{}, fn {key, value} -> {transform_key(key), normalize_payload(value)} end)
  end

  defp normalize_payload(payload) do
    payload
  end

  defp transform_key(key) when is_atom(key) do
    key
    |> Atom.to_string()
    |> transform_key
  end

  defp transform_key(key) do
    key
    |> String.replace(~r/_/, "-")
  end
end
