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

  # Add start readings
  def add_start_readings(config, statement_id) do
    payload =
      %{
        data: %{
          type: "add-start-readings-result",
          relationships: %{
            statement: %{data: %{type: "statements", id: statement_id}}
          }
        }
      }
      |> normalize_payload()

    Request.post(config, "/add-start-readings", payload)
  end

  # Angel Note
  def get_angel_note(config, target_type, target_id) do
    Request.get(config, "/angel-notes/#{target_type}/#{target_id}")
  end

  # Account Payment import
  def import_account_payments(config, fiscal_year_id, external_system, file_base64) do
    payload =
      %{
        data: %{
          type: "account-payment-imports",
          attributes: %{
            fiscal_year_id: fiscal_year_id,
            external_system: external_system,
            file_base64: file_base64
          }
        }
      }
      |> normalize_payload

    Request.post(config, "/fiscal-years/#{fiscal_year_id}/account-payment-imports", payload)
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

  # Calculate missing readings
  def calculate_missing_readings(config, statement_id) do
    payload =
      %{
        data: %{
          type: "calculate-missing-readings",
          relationships: %{
            statement: %{data: %{type: "statements", id: statement_id}}
          }
        }
      }
      |> normalize_payload()

    Request.post(config, "/calculate-missing-readings", payload)
  end

  # Degree days
  def export_degree_days(config, start_date, end_date) do
    payload =
      %{
        data: %{
          type: "degree-days",
          attributes: %{
            start_date: start_date,
            end_date: end_date
          }
        }
      }
      |> normalize_payload

    Request.post(config, "/degree-days", payload)
  end

  # Device
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

  def add_encryption_key(config, id, attrs) do
    payload = %{
      data: %{
        type: "device-add-encryption-key",
        attributes: attrs
      }
    }

    Request.post(config, "/devices/#{id}/add-encryption-key", payload)
  end

  def split_device(config, attrs, rels) do
    payload = %{
      data: %{
        type: "device-splits",
        attributes: attrs,
        relationships: rels
      }
    }

    Request.post(config, "/devices/split", payload)
  end

  def get_device_types(config) do
    Request.get(config, "/device-types")
  end

  def change_device_type(config, id, attrs) do
    payload = %{
      data: %{
        type: "device-change-type",
        attributes: attrs
      }
    }

    Request.post(config, "/devices/#{id}/change-type", payload)
  end

  # Device balancer

  def rebalance_devices(config, admin_id) do
    payload = %{
      data: %{
        type: "device-balancers",
        attributes: %{},
        relationships: %{admin: %{data: %{id: admin_id, type: "admin"}}}
      }
    }

    config
    |> Map.put(:timeout, 60_000)
    |> Request.post("/device-balancer", payload)
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

  # Property

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

  def property_change_admin(config, id, attrs, rels, query \\ %{}) do
    payload = %{
      data: %{
        type: "properties",
        id: id,
        attributes: attrs,
        relationships: rels
      }
    }

    Request.patch(config, "/properties/#{id}/change-admin", payload, query)
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

  # READy
  def ready_installation_matches(config, rels, query \\ %{}) do
    payload = %{
      data: %{
        type: "ready-installation-matches",
        relationships: rels
      }
    }

    Request.post(config, "/ready-installation-matches", payload, query)
  end

  def ready_installation_already_matched(config, rels, query \\ %{}) do
    payload = %{
      data: %{
        type: "ready-installation-already-matched",
        relationships: rels
      }
    }

    Request.post(config, "/ready-installation-already-matched", payload, query)
  end

  def link_ready_installation_match(config, rels, query \\ %{}) do
    payload = %{
      data: %{
        type: "ready-installation-links",
        relationships: rels
      }
    }

    Request.post(config, "/ready-installation-links", payload, query)
  end

  def unlink_ready_installation_match(config, rels, query \\ %{}) do
    payload = %{
      data: %{
        type: "ready-installation-unlinks",
        relationships: rels
      }
    }

    Request.post(config, "/ready-installation-unlinks", payload, query)
  end

  # DS Energy location
  def ds_energy_location_matches(config, rels, query \\ %{}) do
    payload = %{
      data: %{
        type: "ds-energy-location-matches",
        relationships: rels
      }
    }

    Request.post(config, "/ds-energy-location-matches", payload, query)
  end

  def ds_energy_location_already_matched(config, rels, query \\ %{}) do
    payload = %{
      data: %{
        type: "ds-energy-location-already-matched",
        relationships: rels
      }
    }

    Request.post(config, "/ds-energy-location-already-matched", payload, query)
  end

  def link_ds_energy_location_match(config, rels, query \\ %{}) do
    payload = %{
      data: %{
        type: "ds-energy-location-links",
        relationships: rels
      }
    }

    Request.post(config, "/ds-energy-location-links", payload, query)
  end

  def unlink_ds_energy_location_match(config, rels, query \\ %{}) do
    payload = %{
      data: %{
        type: "ds-energy-location-unlinks",
        relationships: rels
      }
    }

    Request.post(config, "/ds-energy-location-unlinks", payload, query)
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

  # Statement
  def create_next_statement(config, prev_statement_id, query) do
    payload = %{
      data: %{
        type: "statements",
        relationships: %{
          statement: %{data: %{type: "statements", id: prev_statement_id}}
        }
      }
    }

    Request.post(config, "/statements/next", payload, query)
  end

  # Run verification
  def run_verification_job(config, statement_check_id) do
    payload = %{
      data: %{
        type: "verification_job",
        attributes: %{
          statement_check_id: statement_check_id
        }
      }
    }

    Request.post(config, "/verification-jobs", payload)
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
