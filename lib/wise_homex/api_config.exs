# The definition of all endpoints that are autogenerated in WiseHomex

endpoints = [
  %{
    endpoints: [:index, :show, :create, :update, :delete],
    model: WiseHomex.Expense,
    name_plural: "expenses",
    name_singular: "expense",
    path: "/expenses",
    type: "expenses"
  },
  %{
    endpoints: [:create],
    model: WiseHomex.WMBusMessageQuery,
    name_plural: "wmbus_message_queries",
    name_singular: "wmbus_message_query",
    path: "/wmbus-message-queries",
    type: "wmbus-message-queries"
  }
]
