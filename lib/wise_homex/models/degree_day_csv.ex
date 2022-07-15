defmodule WiseHomex.DegreeDayCSV do
  @moduledoc false

  use WiseHomex.BaseModel

  embedded_schema do
    field :csv_content, :string
    field :csv_file_name, :string
  end
end
