defmodule WiseHomex.TenancyModelTest do
  @moduledoc false
  use WiseHomex.Test.Case, async: true

  import WiseHomex.Tenancy, only: [sort_date: 1]
  doctest WiseHomex.Tenancy
end
