# The definition of all endpoints that are autogenerated in WiseHomex

endpoints = [
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.Account,
    name_plural: "accounts",
    name_singular: "account",
    path: "/accounts",
    type: "accounts"
  },
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.AccountPayment,
    name_plural: "account_payments",
    name_singular: "account_payment",
    path: "/account-payments",
    type: "account-payments"
  },
  %{
    endpoints: [:index, :delete],
    model: WiseHomex.AccountUser,
    name_plural: "account_users",
    name_singular: "account_user",
    path: "/account-users",
    type: "account-users"
  },
  %{
    endpoints: [:index, :show, :create, :update],
    model: WiseHomex.Address,
    name_plural: "addresses",
    name_singular: "address",
    path: "/addresses",
    type: "addresses"
  },
  %{
    endpoints: [:show, :update],
    model: WiseHomex.AdminData,
    name_plural: "admin_datas",
    name_singular: "admin_data",
    path: "/admin-datas",
    type: "admin-datas"
  },
  %{
    endpoints: [:index, :show, :delete],
    model: WiseHomex.AdminIntegration,
    name_plural: "admin_integrations",
    name_singular: "admin_integration",
    path: "/admin-integrations",
    type: "admin-integrations"
  },
  %{
    endpoints: [:create, :update],
    model: WiseHomex.AdminIntegration,
    name_plural: "admin_integrations_unik",
    name_singular: "admin_integration_unik",
    path: "/admin-integrations/unik",
    type: "admin-integrations"
  },
  %{
    endpoints: [:create, :update, :delete],
    model: WiseHomex.AngelNote,
    name_plural: "angel_notes",
    name_singular: "angel_note",
    path: "/angel-notes",
    type: "angel-notes"
  },
  %{
    endpoints: [:create],
    model: WiseHomex.AngelNoteBunch,
    name_plural: "angel_note_bunches",
    name_singular: "angel_note_bunch",
    path: "/angel-note-bunches",
    type: "angel-note-bunches"
  },
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.Device,
    name_plural: "devices",
    name_singular: "device",
    path: "/devices",
    type: "devices"
  },
  %{
    endpoints: [:show, :create, :update, :delete],
    model: WiseHomex.DistributedExpense,
    name_plural: "distributed_expenses",
    name_singular: "distributed_expense",
    path: "/distributed-expenses",
    type: "distributed-expenses"
  },
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.Expense,
    name_plural: "expenses",
    name_singular: "expense",
    path: "/expenses",
    type: "expenses"
  },
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.ExternalHousehold,
    name_plural: "external_households",
    name_singular: "external_household",
    path: "/external-households",
    type: "external-households"
  },
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.ExternalProperty,
    name_plural: "external_properties",
    name_singular: "external_property",
    path: "/external-properties",
    type: "external-properties"
  },
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.ExternalResource,
    name_plural: "external_resources",
    name_singular: "external_resource",
    path: "/external-resources",
    type: "external-resources"
  },
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.ExternalTenancy,
    name_plural: "external_tenancies",
    name_singular: "external_tenancy",
    path: "/external-tenancies",
    type: "external-tenancies"
  },
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.ExternalVacancy,
    name_plural: "external_vacancies",
    name_singular: "external_vacancy",
    path: "/external-vacancies",
    type: "external-vacancies"
  },
  %{
    endpoints: [:index, :create, :delete],
    model: WiseHomex.Firmware,
    name_plural: "firmwares",
    name_singular: "firmware",
    path: "/firmwares",
    type: "firmwares"
  },
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.FiscalYear,
    name_plural: "fiscal_years",
    name_singular: "fiscal_year",
    path: "/fiscal-years",
    type: "fiscal-years"
  },
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.ForeignDevice,
    name_plural: "foreign_devices",
    name_singular: "foreign_device",
    path: "/foreign-devices",
    type: "foreign-devices"
  },
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.FuelCheckPoint,
    name_plural: "fuel_check_points",
    name_singular: "fuel_check_point",
    path: "/fuel-check-points",
    type: "fuel-check-points"
  },
  %{
    endpoints: [:index, :show, :update, :delete],
    model: WiseHomex.Gateway,
    name_plural: "gateways",
    name_singular: "gateway",
    path: "/gateways",
    type: "gateways"
  },
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.HeatSource,
    name_plural: "heat_sources",
    name_singular: "heat_source",
    path: "/heat-sources",
    type: "heat-sources"
  },
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.Household,
    name_plural: "households",
    name_singular: "household",
    path: "/households",
    type: "households"
  },
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.Property,
    name_plural: "properties",
    name_singular: "property",
    path: "/properties",
    type: "properties"
  },
  %{
    endpoints: [:index, :show],
    model: WiseHomex.Radiator,
    name_plural: "radiators",
    name_singular: "radiator",
    path: "/radiators",
    type: "radiators"
  },
  %{
    endpoints: [:show],
    model: WiseHomex.RadiatorInfo,
    name_plural: "radiator_infos",
    name_singular: "radiator_info",
    path: "/radiator-infos",
    type: "radiator-infos"
  },
  %{
    endpoints: [:index, :show, :update],
    model: WiseHomex.ReadyGroup,
    name_plural: "ready_groups",
    name_singular: "ready_group",
    path: "/ready-groups",
    type: "ready-groups"
  },
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.Room,
    name_plural: "rooms",
    name_singular: "room",
    path: "/rooms",
    type: "rooms"
  },
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.SettlementKey,
    name_plural: "settlement_keys",
    name_singular: "settlement_key",
    path: "/settlement-keys",
    type: "settlement-keys"
  },
  %{
    endpoints: [:show, :create, :update, :delete],
    model: WiseHomex.SettlementValue,
    name_plural: "settlement_values",
    name_singular: "settlement_value",
    path: "/settlement-values",
    type: "settlement-values"
  },
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.Sim,
    name_plural: "sims",
    name_singular: "sim",
    path: "/sims",
    type: "sims"
  },
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.Statement,
    name_plural: "statements",
    name_singular: "statement",
    path: "/statements",
    type: "statements"
  },
  %{
    endpoints: [:show, :update],
    model: WiseHomex.StatementConfig,
    name_plural: "statement_configs",
    name_singular: "statement_config",
    path: "/statement-configs",
    type: "statement-configs"
  },
  %{
    endpoints: [:show, :create],
    model: WiseHomex.StatementData,
    name_plural: "statement_datas",
    name_singular: "statement_data",
    path: "/statement-data",
    type: "statement-data"
  },
  %{
    endpoints: [:create],
    model: WiseHomex.StatementFile,
    name_plural: "statement_files",
    name_singular: "statement_file",
    path: "/statement-files",
    type: "statement-files"
  },
  %{
    endpoints: [:create],
    model: WiseHomex.StatementZip,
    name_plural: "statement_zips",
    name_singular: "statement_zip",
    path: "/statement-zips",
    type: "statement-zips"
  },
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.Tenancy,
    name_plural: "tenancies",
    name_singular: "tenancy",
    path: "/tenancies",
    type: "tenancies"
  },
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.UnsuccessfulVisit,
    name_plural: "unsuccessful_visits",
    name_singular: "unsuccessful_visit",
    path: "/unsuccessful-visits",
    type: "unsuccessful-visits"
  },
  %{
    endpoints: [:index],
    model: WiseHomex.User,
    name_plural: "users",
    name_singular: "user",
    path: "/users",
    type: "users"
  },
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.UtilityReading,
    name_plural: "utility_readings",
    name_singular: "utility_reading",
    path: "/utility-readings",
    type: "utility-readings"
  },
  %{
    endpoints: [:update],
    model: WiseHomex.VacancyAccountPayment,
    name_plural: "vacancy-account-payments",
    name_singular: "vacancy_account_payment",
    path: "/vacancy-account-payments",
    type: "vacancy-account-payments"
  },
  %{
    endpoints: [:create],
    model: WiseHomex.WMBusMessageQuery,
    name_plural: "wmbus_message_queries",
    name_singular: "wmbus_message_query",
    path: "/wmbus-message-queries",
    type: "wmbus-message-queries"
  },
  %{
    endpoints: [:index],
    model: WiseHomex.ZipCode,
    name_plural: "zip_codes",
    name_singular: "zip_code",
    path: "/zip-codes",
    type: "zip-codes"
  }
]
