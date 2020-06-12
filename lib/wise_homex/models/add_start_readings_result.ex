defmodule WiseHomex.AddStartReadingsResult do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    field :reading_count_by_date, :map
  end
end
