defmodule WiseHomex.TenancyModelTest do
  @moduledoc false
  use ExUnit.Case, async: true

  import WiseHomex.Tenancy, only: [sort_date: 1]
  doctest WiseHomex.Tenancy
end
