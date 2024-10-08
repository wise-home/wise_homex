defmodule WiseHomex.JSONParser do
  @moduledoc """
  Parses a jsonapi response from the api.
  """

  alias Ecto.Changeset

  @structs %{
             "account-email-settings" => WiseHomex.Account.EmailSettings,
             "add-start-readings-result" => WiseHomex.AddStartReadingsResult,
             "configurable-meter-id" => WiseHomex.ConfigurableMeterID,
             "configurable-meters" => WiseHomex.ConfigurableMeters,
             "delete-tap-shares-for-households-result" => WiseHomex.DeleteTapSharesForHouseholdsResult,
             "degree-days" => WiseHomex.DegreeDay,
             "device-imports" => WiseHomex.DeviceImport,
             "device-types" => WiseHomex.DeviceType,
             "ds-energy-location-already-matched" => WiseHomex.DSEnergyLocationMatch,
             "ds-energy-location-matches" => WiseHomex.DSEnergyLocationMatch,
             "encryption-keys" => WiseHomex.EncKey,
             "jobs" => WiseHomex.Job,
             "kems" => WiseHomex.KEMInfo,
             "latest-reports" => WiseHomex.LatestReport,
             "measurements" => WiseHomex.Measurement,
             "message-reports" => WiseHomex.MessageReport,
             "pongs" => WiseHomex.Pong,
             "radiator-import-results" => WiseHomex.RadiatorImportResult,
             "ready-installation-already-matched" => WiseHomex.ReadyInstallationMatch,
             "ready-installation-matches" => WiseHomex.ReadyInstallationMatch,
             "tap-places" => WiseHomex.TapPlace,
             "technician-accesses" => WiseHomex.TechnicianAccess,
             "vacancies" => WiseHomex.Vacancy,
             "vacancy-infos" => WiseHomex.VacancyInfo,
             "wmbus-device-types" => WiseHomex.WMBusDeviceType,
             "wmbus-manufacturers" => WiseHomex.WMBusManufacturer,
             "wmbus-message-infos" => WiseHomex.WMBusMessageInfo,
             "wmbus-measurement-modifications" => WiseHomex.WMBusMeasurementModification
           }
           |> Map.merge(WiseHomex.ApiDefinition.type_to_model_mappings())

  @spec parse(map | [map]) :: struct | [struct]
  def parse(json) do
    data = json["data"]
    included = json["included"] || []

    data_entities = parse_required_entities(List.flatten([data]))
    included_entities = parse_optional_entities(included)

    entities =
      (data_entities ++ included_entities)
      |> Enum.into(%{}, fn {ident, _struct, _rels} = entity ->
        key = {Map.fetch!(ident, "type"), Map.fetch!(ident, "id")}
        {key, entity}
      end)

    result =
      data_entities
      |> Enum.map(&add_relations(&1, entities))
      |> Enum.map(fn {_, struct, _} -> struct end)

    case data do
      list when is_list(list) ->
        result

      _ ->
        [result] = result
        result
    end
  end

  @doc """
  Format errors returned from the API.
  It expects an array like this:

  [%{"detail" => "has already been taken", "source" => %{"parameter" => "name"}, "title" => "Validation error"}]
  """
  def format_errors(%{"errors" => errors}) do
    format_errors(errors)
  end

  def format_errors(errors) do
    errors
    |> Enum.map(fn
      %{"source" => %{"parameter" => param}, "detail" => detail} ->
        "#{param} #{detail}"

      %{"detail" => detail} ->
        detail

      %{"title" => title} ->
        title
    end)
    |> Enum.join(", ")
  end

  # Returns a {identifier, struct, [key: identifier] = rels} tuple
  # wrapped inside a {:ok, result} or {:error, reason}
  defp parse_entity(entity_data) do
    identifier = parse_identifier(entity_data)

    attributes =
      entity_data
      |> Map.get("attributes", %{})
      |> Enum.into(%{}, fn {k, v} -> {transform_key(k), v} end)

    type = entity_data |> Map.get("type")

    with {:ok, struct} <- type_to_struct(type) do
      relationships =
        entity_data
        |> Map.get("relationships", %{})
        |> Enum.map(fn {key, rel} -> {transform_key(key), parse_identifier(rel["data"])} end)

      struct =
        struct
        |> set_struct_attributes(attributes)
        |> set_struct_relation_ids(relationships)
        |> merge_id(entity_data)

      {:ok, {identifier, struct, relationships}}
    end
  end

  defp parse_entity!(entity_data) do
    {:ok, entity} = parse_entity(entity_data)
    entity
  end

  defp parse_identifier(list) when is_list(list) do
    Enum.map(list, &parse_identifier/1)
  end

  defp parse_identifier(%{"type" => type, "id" => id}) do
    %{"type" => type, "id" => id}
  end

  defp parse_identifier(nil) do
    nil
  end

  defp add_relations(entity, entities) do
    add_relations(entity, entities, MapSet.new())
  end

  defp add_relations(nil, _entities, _path) do
    nil
  end

  defp add_relations(list, entities, path) when is_list(list) do
    list |> Enum.map(&add_relations(&1, entities, path))
  end

  defp add_relations({ident, struct, rels} = entity, entities, path) do
    if MapSet.member?(path, ident) do
      entity
    else
      struct =
        rels
        |> find_related_entities(entities)
        |> Enum.map(fn {key, relation} ->
          relation = add_relations(relation, entities, MapSet.put(path, ident))
          {key, relation}
        end)
        |> add_related_entities(struct)

      {ident, struct, []}
    end
  end

  defp find_related_entities([], _entities) do
    []
  end

  defp find_related_entities([{key, rel} | rest], entities) do
    related =
      case rel do
        rels when is_list(rels) ->
          rels
          |> Enum.map(&find_entity(entities, &1))
          |> Enum.reject(&is_nil/1)

        rel ->
          find_entity(entities, rel)
      end

    [{key, related} | find_related_entities(rest, entities)]
  end

  defp find_entity(_entities, nil), do: nil

  defp find_entity(entities, identifier) do
    key = {Map.fetch!(identifier, "type"), Map.fetch!(identifier, "id")}

    entities
    |> Map.get(key)
  end

  for {type, module} <- @structs do
    defp type_to_struct(unquote(type)), do: {:ok, struct(unquote(module))}
  end

  defp type_to_struct(type), do: {:error, "Unknown type #{type}"}

  defp parse_id(nil), do: :none
  defp parse_id(""), do: :none
  defp parse_id(id_string) when is_binary(id_string), do: id_string
  defp parse_id(_), do: :none

  defp merge_id(struct, %{"id" => id}) do
    case parse_id(id) do
      :none -> struct
      id -> set_struct_attribute(struct, :id, id)
    end
  end

  defp transform_key(key) do
    key
    |> String.replace(~r/-/, "_")
    |> String.to_atom()
  end

  defp add_related_entities([], struct) do
    struct
  end

  defp add_related_entities([{key, relation} | rest], struct) do
    add_related_entities(rest, add_related_entity(key, relation, struct))
  end

  defp add_related_entity(key, {_, related_struct, _}, struct) do
    id_key = "#{key}_id" |> String.to_atom()

    struct
    |> set_struct_attribute(key, related_struct)
    |> set_struct_attribute(id_key, related_struct.id)
  end

  defp add_related_entity(key, nil, struct) do
    struct
    |> set_struct_attribute(key, nil)
  end

  defp add_related_entity(key, list, struct) when is_list(list) do
    related_structs = list |> Enum.map(fn {_, related_struct, _} -> related_struct end)
    set_struct_attribute(struct, key, related_structs)
  end

  defp set_struct_attributes(struct, attributes) do
    Enum.reduce(attributes, struct, fn {key, value}, struct ->
      set_struct_attribute(struct, key, value)
    end)
  end

  defp set_struct_relation_ids(struct, relationships) do
    relationships
    |> Enum.reduce(struct, fn
      {name, %{"id" => id}}, struct ->
        case parse_id(id) do
          :none ->
            struct

          id ->
            id_name = "#{name}_id" |> String.to_atom()
            set_struct_attribute(struct, id_name, id)
        end

      _, struct ->
        struct
    end)
  end

  defp set_struct_attribute(struct, key, value) do
    struct_types = ecto_types(struct)

    case Map.fetch(struct_types, key) do
      {:ok, {:embed, embedded_type}} ->
        # Convert embedded value
        convert_ecto_embedded_value(struct, embedded_type, key, value)

      {:ok, type} when is_atom(type) ->
        convert_ecto_value(struct, key, value)

      {:ok, _} ->
        # Otherwise just set the value
        %{struct | key => value}

      _ ->
        struct
    end
  end

  defp ecto_types(struct) do
    # Get struct module name
    %{__struct__: module} = struct
    # Call ecto function to get a map of {key, ecto-type}
    module.__changeset__()
  end

  # Using Ecto to convert a single value to the type defined in the Ecto schema
  defp convert_ecto_value(struct, key, value) do
    struct
    |> Changeset.cast(%{key => value}, [key])
    |> Changeset.apply_changes()
  end

  defp convert_ecto_embedded_value(struct, %Ecto.Embedded{} = embedded_type, key, value) do
    embedded_module = embedded_type.related

    embedded_value =
      case embedded_type.cardinality do
        :one -> parse_embed(embedded_module, value)
        :many -> Enum.map(value, &parse_embed(embedded_module, &1))
      end

    %{struct | key => embedded_value}
  end

  defp parse_embed(_module, nil) do
    nil
  end

  # If the value is a struct, it is already parsed because it is in the included list
  defp parse_embed(_module, %{__struct__: _} = parsed_value) do
    parsed_value
  end

  # If it's a map of attributes, it does not have it's own json-api type. Parse it to the given Ecto module
  defp parse_embed(module, %{} = attributes) do
    struct = struct(module)

    attributes
    |> Enum.reduce(struct, fn {key, value}, struct ->
      set_struct_attribute(struct, transform_key(key), value)
    end)
  end

  # If it's something else, it must be able to parse itself
  defp parse_embed(module, data) do
    {:ok, model} = module.cast(data)
    model
  end

  defp parse_required_entities(data) do
    data
    |> Enum.map(&parse_entity!/1)
  end

  defp parse_optional_entities(data) do
    data
    |> Enum.map(&parse_entity/1)
    |> Enum.filter(fn
      {:ok, _} -> true
      _ -> false
    end)
    |> Enum.map(fn {:ok, entity} -> entity end)
  end
end
