defmodule WiseHomex.ApiClientImpl do
  @moduledoc """
  The Wise Home Api Client.

  Requires an implementation to be used. This will be read at runtime and default
  to WiseHomex.Http. Any implementation must implement WiseHomex.ApiClient.Behaviour.
  An alternative is WiseHomex.Test.Mock which can be used to test the client.
  """

  @behaviour WiseHomex.ApiClientBehaviour

  alias WiseHomex.Request

  use WiseHomex.ApiClientImpl.Creator

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

  # Angel Note
  def get_angel_note(config, target_type, target_id) do
    Request.get(config, "/angel-notes/#{target_type}/#{target_id}")
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
  def authorize_device(config, device_id) do
    Request.post(config, "/devices/" <> device_id <> "/authorizations")
  end

  def deauthorize_device(config, device_id) do
    Request.delete(config, "/devices/" <> device_id <> "/authorizations")
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

  # Gateway
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

  # Radiator
  def import_radiators(config, attrs) do
    payload = %{
      data: %{
        type: "radiator-imports",
        attributes: attrs
      }
    }

    Request.post(config, "/radiators/import", payload)
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

    Request.post(config, "/reports/latest", payload, query)
  end

  def get_device_reports(config, id) do
    Request.get(config, "/devices/" <> id <> "/reports")
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

  # Wmbus Cache
  def get_wmbus_cache(config, gateway_id, query \\ %{}) do
    Request.get(config, "/gateways/" <> gateway_id <> "/wmbus-meters/cache", query)
  end

  def refresh_wmbus_cache(config, gateway_id) do
    Request.post(config, "/gateways/" <> gateway_id <> "/wmbus-meters/cache")
  end

  # Utility functions
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
