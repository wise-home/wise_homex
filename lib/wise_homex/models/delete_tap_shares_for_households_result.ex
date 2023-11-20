defmodule WiseHomex.DeleteTapSharesForHouseholdsResult do
  @moduledoc """
  Result from a delete tap shares operation.
  """

  use WiseHomex.BaseModel

  embedded_schema do
    field :household_ids_deleted_tap_shares, {:array, :integer}
    field :household_ids_limited_active_period_tap_shares, {:array, :integer}
  end
end
