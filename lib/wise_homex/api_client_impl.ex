defmodule WiseHomex.ApiClientImpl do
  @moduledoc """
  The Wise Home Api Client.

  Requires an implementation to be used. This will be read at runtime and default
  to WiseHomex.Http. Any implementation must implement WiseHomex.ApiClient.Behaviour.
  An alternative is WiseHomex.Test.Mock which can be used to test the client.
  """

  @behaviour WiseHomex.ApiClientBehaviour

  alias WiseHomex.Quantity
  alias WiseHomex.Request

  # Account
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

    Request.post(config, "/accounts", params)
  end

  def delete_account(config, id) do
    Request.delete(config, "/accounts/" <> id)
  end

  def get_account(config, id, query \\ %{}) do
    Request.get(config, "/accounts/" <> id, query)
  end

  def get_accounts(config, query \\ %{}) do
    Request.get(config, "/accounts", query)
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

    Request.patch(config, "/accounts/" <> id, payload)
  end

  # Account User
  def get_account_users(config, query) do
    Request.get(config, "/account-users", query)
  end

  def delete_account_user(config, id) do
    Request.delete(config, "/account-users/#{id}")
  end

  # Address
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

    Request.post(config, "/addresses", params)
  end

  def update_address(config, id, attrs) do
    params =
      %{
        data: %{
          type: "addresses",
          id: id,
          attributes: attrs
        }
      }
      |> normalize_payload

    Request.patch(config, "/addresses/#{id}", params)
  end

  def get_address(config, id, query \\ %{}) do
    Request.get(config, "/addresses/" <> id, query)
  end

  def get_addresses(config, query \\ %{}) do
    Request.get(config, "/addresses", query)
  end

  # Admin integration
  def delete_admin_integration(config, id) do
    Request.delete(config, "/admin-integrations/" <> id)
  end

  def get_admin_integrations(config, query \\ %{}) do
    Request.get(config, "/admin-integrations", query)
  end

  def get_admin_integration(config, id, query \\ %{}) do
    Request.get(config, "/admin-integrations/" <> id, query)
  end

  # Admin integration UNIK
  def create_admin_integration_unik(config, attrs, rels) do
    params =
      %{
        data: %{
          type: "admin-integrations",
          attributes: attrs,
          relationships: rels
        }
      }
      |> normalize_payload

    Request.post(config, "/admin-integrations/unik", params)
  end

  def update_admin_integration_unik(config, id, attrs) do
    params =
      %{
        data: %{
          type: "admin-integrations",
          id: id,
          attributes: attrs
        }
      }
      |> normalize_payload

    Request.patch(config, "/admin-integrations/unik/" <> id, params)
  end

  # Angel Note
  def create_angel_note(config, attrs) do
    payload =
      %{
        data: %{
          type: "angel-notes",
          attributes: attrs
        }
      }
      |> normalize_payload

    Request.post(config, "/angel-notes", payload)
  end

  def delete_angel_note(config, id) do
    Request.delete(config, "/angel-notes/" <> id)
  end

  def get_angel_note(config, target_type, target_id) do
    Request.get(config, "/angel-notes/#{target_type}/#{target_id}")
  end

  def update_angel_note(config, id, attrs) do
    payload =
      %{
        data: %{
          type: "angel-notes",
          id: id,
          attributes: attrs
        }
      }
      |> normalize_payload

    Request.patch(config, "/angel-notes/" <> id, payload)
  end

  # Bmeters Keys
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

    Request.post(config, "/bmeters/keys", payload)
  end

  # Device
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

    Request.post(config, "/devices", payload)
  end

  def authorize_device(config, device_id) do
    Request.post(config, "/devices/" <> device_id <> "/authorizations")
  end

  def deauthorize_device(config, device_id) do
    Request.delete(config, "/devices/" <> device_id <> "/authorizations")
  end

  def delete_device(config, id) do
    Request.delete(config, "/devices/" <> id)
  end

  def fast_ping_device(config, id) do
    params =
      %{
        data: %{
          type: "device-fast-pings"
        }
      }
      |> normalize_payload

    Request.post(config, "/devices/" <> id <> "/fast-pings", params)
  end

  def get_device(config, id, query \\ %{}) do
    Request.get(config, "/devices/" <> id, query)
  end

  def get_devices(config, query \\ %{}) do
    Request.get(config, "/devices", query)
  end

  def set_device_location(config, device_id, attrs, rels) do
    payload =
      %{
        data: %{
          type: "device-locations",
          attributes: attrs,
          relationships: rels
        }
      }
      |> normalize_payload()

    Request.post(config, "/devices/#{device_id}/location", payload)
  end

  def unset_device_location(config, device_id) do
    Request.delete(config, "/devices/#{device_id}/location")
  end

  def update_device(config, id, attrs, rels) do
    payload =
      %{
        data: %{
          type: "devices",
          id: id,
          attributes: attrs,
          relationships: rels
        }
      }
      |> normalize_payload()

    Request.patch(config, "/devices/#{id}", payload)
  end

  def import_devices(config, attrs, rels) do
    payload = %{
      data: %{
        type: "device-imports",
        attributes: attrs,
        relationships: rels
      }
    }

    Request.post(config, "/devices/import", payload)
  end

  # Radiator

  def get_radiator(config, id, query \\ %{}) do
    Request.get(config, "/radiators/#{id}", query)
  end

  def get_radiators(config, query \\ %{}) do
    Request.get(config, "/radiators", query)
  end

  def import_radiators(config, attrs) do
    payload = %{
      data: %{
        type: "radiator-imports",
        attributes: attrs
      }
    }

    Request.post(config, "/radiators/import", payload)
  end

  # Email Settings

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

    Request.patch(config, "/accounts/" <> account_id <> "/email-settings", payload)
  end

  # External Info

  def create_external_info(config, attributes, relationships) do
    payload =
      %{
        data: %{
          type: "external-infos",
          attributes: attributes,
          relationships: relationships
        }
      }
      |> normalize_payload

    Request.post(config, "/external-infos", payload)
  end

  def delete_external_info(config, id) do
    Request.delete(config, "/external-infos/" <> id)
  end

  def update_external_info(config, id, attributes) do
    payload =
      %{
        data: %{
          type: "external-infos",
          id: id,
          attributes: attributes
        }
      }
      |> normalize_payload

    Request.patch(config, "/external-infos/" <> id, payload)
  end

  # Firmware

  def create_firmware(config, file_content) do
    payload = %{
      data: %{
        type: "firmwares",
        attributes: %{
          content_base64: file_content |> Base.encode64()
        }
      }
    }

    Request.post(config, "/firmwares", payload)
  end

  def delete_firmware(config, id) do
    Request.delete(config, "/firmwares/" <> id)
  end

  def get_firmwares(config) do
    Request.get(config, "/firmwares", %{"page[size]" => 500})
  end

  # Gateway

  def get_gateway(config, id, query \\ %{}) do
    Request.get(config, "/gateways/" <> id, query)
  end

  def get_gateways(config, query \\ %{}) do
    Request.get(config, "/gateways", query)
  end

  def delete_gateway(config, id) do
    Request.delete(config, "/gateways/" <> id)
  end

  def lock_gateway(config, id) do
    payload =
      %{
        data: %{
          type: "gateway-locks"
        }
      }
      |> normalize_payload

    Request.post(config, "/gateways/" <> id <> "/locks", payload)
  end

  def restart_gateway(config, id) do
    payload =
      %{
        data: %{
          type: "gateway-restarts"
        }
      }
      |> normalize_payload

    Request.post(config, "/gateways/" <> id <> "/restarts", payload)
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

    Request.post(config, "/gateways/" <> id <> "/unlocks", payload)
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

    Request.patch(config, "/gateways/" <> id, payload)
  end

  # HeatSource
  def get_heat_source(config, id, query \\ %{}) do
    Request.get(config, "/heat-sources/#{id}", query)
  end

  def get_heat_sources(config, query \\ %{}) do
    Request.get(config, "/heat-sources", query)
  end

  # Household

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

    Request.post(config, "/households", params)
  end

  def delete_household(config, id) do
    Request.delete(config, "/households/" <> id)
  end

  def get_household(config, id, query \\ %{}) do
    Request.get(config, "/households/" <> id, query)
  end

  def get_households(config, query \\ %{}) do
    Request.get(config, "/households", query)
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

    Request.patch(config, "/households/" <> id, params)
  end

  # Account invitation

  def create_account_invitation(config, account_id, attrs) do
    payload =
      %{
        data: %{
          type: "account-invitations",
          attributes: attrs
        }
      }
      |> normalize_payload

    Request.post(config, "/accounts/" <> account_id <> "/invitations", payload)
  end

  # KEM uploads

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
    |> Request.post("/kamstrup/kems", payload)
  end

  # Ping

  def ping(config, query) do
    Request.get(config, "/ping", query)
  end

  # Property

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

    Request.post(config, "/properties", params)
  end

  def delete_property(config, id) do
    Request.delete(config, "/properties/" <> id)
  end

  def get_properties(config, query \\ %{}) do
    Request.get(config, "/properties", query)
  end

  def get_property(config, id, query \\ %{}) do
    Request.get(config, "/properties/" <> id, query)
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

    Request.patch(config, "/properties/" <> id, params)
  end

  # Property Syncs

  @doc """
  Trigger sync of an existing property
  """
  def sync_property(config, property_id) do
    params =
      %{
        data: %{
          type: "property-syncs",
          relationships: %{
            property: %{data: %{type: "properties", id: property_id}}
          }
        }
      }
      |> normalize_payload

    config
    |> Map.update!(:timeout, fn _ -> 30_000 end)
    |> Request.post("/property-syncs", params)
  end

  # Property Syncs UNIK

  @doc """
  Create a synced property from UNIK
  Both property_number and company_number are the numbers from the UNIK system
  """
  def create_synced_property_unik(config, property_number, company_number, admin_id) do
    params =
      %{
        data: %{
          type: "property-syncs",
          attributes: %{
            property_number: property_number,
            company_number: company_number
          },
          relationships: %{
            admin: %{data: %{type: "accounts", id: admin_id}}
          }
        }
      }
      |> normalize_payload

    config
    |> Map.update!(:timeout, fn _ -> 30_000 end)
    |> Request.post("/property-syncs/unik", params)
  end

  # Reports

  def create_latest_report(config, device_id, query \\ %{}) do
    payload = %{
      data: %{
        type: "latest-reports",
        relationships: %{
          device: %{data: %{type: "devices", id: device_id}}
        }
      }
    }

    Request.post(config, "/reports/latest", query, payload)
  end

  def get_device_reports(config, id) do
    Request.get(config, "/devices/" <> id <> "/reports")
  end

  # Room

  def create_room(config, attrs, rels) do
    params = %{
      data: %{
        type: "rooms",
        attributes: attrs,
        relationships: rels
      }
    }

    Request.post(config, "/rooms", params)
  end

  def delete_room(config, id) do
    Request.delete(config, "/rooms/" <> id)
  end

  def get_room(config, id, query \\ %{}) do
    Request.get(config, "/rooms/" <> id, query)
  end

  def get_rooms(config, query) do
    Request.get(config, "/rooms", query)
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

    Request.patch(config, "/rooms/" <> id, payload)
  end

  # Tenancy

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

    Request.post(config, "/tenancies", params)
  end

  def delete_tenancy(config, id) do
    Request.delete(config, "/tenancies/" <> id)
  end

  def get_tenancy(config, id, query \\ %{}) do
    Request.get(config, "/tenancies/" <> id, query)
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

    Request.patch(config, "/tenancies/" <> id, payload)
  end

  # SettlementKey
  def get_settlement_key(config, id, query \\ %{}) do
    Request.get(config, "/settlement-keys/#{id}", query)
  end

  def get_settlement_keys(config, query) do
    Request.get(config, "/settlement-keys", query)
  end

  def create_settlement_key(config, attrs, rels) do
    payload =
      %{
        data: %{
          type: "settlement-keys",
          attributes: attrs,
          relationships: rels
        }
      }
      |> normalize_payload()

    Request.post(config, "/settlement-keys", payload)
  end

  def update_settlement_key(config, id, attrs) do
    payload =
      %{
        data: %{
          type: "settlement-keys",
          id: id,
          attributes: attrs
        }
      }
      |> normalize_payload()

    Request.patch(config, "/settlement-keys/#{id}", payload)
  end

  def delete_settlement_key(config, id) do
    Request.delete(config, "/settlement-keys/#{id}")
  end

  # SettlementValue

  def get_settlement_value(config, id, query \\ %{}) do
    Request.get(config, "/settlement-values/#{id}", query)
  end

  def create_settlement_value(config, attrs, rels) do
    payload =
      %{
        data: %{
          type: "settlement-values",
          attributes: attrs,
          relationships: rels
        }
      }
      |> normalize_payload()

    Request.post(config, "/settlement-values", payload)
  end

  def update_settlement_value(config, id, attrs) do
    payload =
      %{
        data: %{
          type: "settlement-values",
          id: id,
          attributes: attrs
        }
      }
      |> normalize_payload()

    Request.patch(config, "/settlement-values/#{id}", payload)
  end

  def delete_settlement_value(config, id) do
    Request.delete(config, "/settlement-values/#{id}")
  end

  # SIM

  def create_sim(config, attrs) do
    payload =
      %{
        data: %{
          type: "sims",
          attributes: attrs
        }
      }
      |> normalize_payload

    Request.post(config, "/sims", payload)
  end

  def delete_sim(config, id) do
    Request.delete(config, "/sims/" <> id)
  end

  def get_sim(config, id, query \\ %{}) do
    Request.get(config, "/sims/" <> id, query)
  end

  def get_sims(config, query \\ %{}) do
    Request.get(config, "/sims", query)
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

    Request.patch(config, "/sims/" <> id, payload)
  end

  # Statement

  def get_statement(config, id, query \\ %{}) do
    Request.get(config, "/statements/#{id}", query)
  end

  def get_statements(config, query \\ %{}) do
    Request.get(config, "/statements", query)
  end

  def create_statement(config, attrs, rels) do
    payload =
      %{
        type: "statements",
        attributes: attrs,
        relationships: rels
      }
      |> normalize_payload()

    Request.post(config, "/statements", payload)
  end

  def update_statement(config, id, attrs) do
    payload =
      %{
        type: "statements",
        id: id,
        attributes: attrs
      }
      |> normalize_payload()

    Request.patch(config, "/statements/#{id}", payload)
  end

  def delete_statement(config, id) do
    Request.delete(config, "/statements/#{id}")
  end

  # User

  def get_users(config, filters \\ []) do
    query =
      filters
      |> Enum.map(fn {key, value} ->
        "filter[#{key}]=#{value}"
      end)
      |> Enum.join("&")

    query = if query == "", do: query, else: "?#{query}"
    Request.get(config, "/users#{query}")
  end

  # UtilityReading

  def get_utility_reading(config, id, query \\ %{}) do
    Request.get(config, "/utility-readings/#{id}", query)
  end

  def get_utility_readings(config, query \\ %{}) do
    Request.get(config, "/utility-readings", query)
  end

  def create_utility_reading(config, attrs, rels) do
    payload =
      %{
        data: %{
          type: "utility-readings",
          attributes: attrs,
          relationships: rels
        }
      }
      |> normalize_payload()

    Request.post(config, "/utility-readings", payload)
  end

  def update_utility_reading(config, id, attrs, rels) do
    payload =
      %{
        data: %{
          type: "utility-readings",
          id: id,
          attributes: attrs,
          relationships: rels
        }
      }
      |> normalize_payload()

    Request.patch(config, "/utility-readings/#{id}", payload)
  end

  def delete_utility_reading(config, id) do
    Request.delete(config, "/utility-readings/#{id}")
  end

  # Wmbus Cache

  def get_wmbus_cache(config, gateway_id, query \\ %{}) do
    Request.get(config, "/gateways/" <> gateway_id <> "/wmbus-meters/cache", query)
  end

  def refresh_wmbus_cache(config, gateway_id) do
    Request.post(config, "/gateways/" <> gateway_id <> "/wmbus-meters/cache")
  end

  def get_zip_codes(config) do
    Request.get(config, "/zip-codes")
  end

  defp normalize_payload(%Date{} = date) do
    Date.to_string(date)
  end

  defp normalize_payload(%DateTime{} = time) do
    DateTime.to_iso8601(time)
  end

  defp normalize_payload(%Quantity{} = quantity) do
    Quantity.to_string(quantity)
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
