# The definition of all endpoints that are autogenerated in WiseHomex

endpoints = [
  %{
    endpoints: [:show, :create, :update, :delete],
    model: WiseHomex.AccountPayment,
    name_plural: "account_payments",
    name_singular: "account_payment",
    path: "/account-payments",
    type: "account-payments"
  },
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.Account,
    name_plural: "accounts",
    name_singular: "account",
    path: "/accounts",
    type: "accounts"
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
    endpoints: [:create],
    model: WiseHomex.AngelNoteBunch,
    name_plural: "angel_note_bunches",
    name_singular: "angel_note_bunch",
    path: "/angel-note-bunches",
    type: "angel-note-bunches"
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
    endpoints: [:index, :show, :update, :delete],
    model: WiseHomex.Device,
    name_plural: "devices",
    name_singular: "device",
    path: "/devices",
    type: "devices"
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
    endpoints: [:create, :update, :delete],
    model: WiseHomex.ExternalInfo,
    name_plural: "external_infos",
    name_singular: "external_info",
    path: "/external-infos",
    type: "external-infos"
  },
  %{
    endpoints: [:index, :delete],
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
    endpoints: [:index, :show, :update, :delete],
    model: WiseHomex.Gateway,
    name_plural: "gateways",
    name_singular: "gateway",
    path: "/gateways",
    type: "gateways"
  },
  %{
    endpoints: [:index, :show],
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
    endpoints: [:show, :create],
    model: WiseHomex.StatementData,
    name_plural: "statement_datas",
    name_singular: "statement_data",
    path: "/statement-data",
    type: "statement-data"
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
    endpoints: [:create],
    model: WiseHomex.WMBusMessageQuery,
    name_plural: "wmbus_message_queries",
    name_singular: "wmbus_message_query",
    path: "/wmbus-message-queries",
    type: "wmbus-message-queries"
  },
  %{
    endpoints: [:show, :update],
    model: WiseHomex.StatementConfig,
    name_plural: "statement_configs",
    name_singular: "statement_config",
    path: "/statement-configs",
    type: "statement-configs"
  }
]
