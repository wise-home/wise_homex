defmodule WiseHomex.AngelNoteBunch do
  @moduledoc """
  An AngelNoteBunch is a collection of angel notes
  """

  use WiseHomex.BaseModel

  embedded_schema do
    embeds_many :angel_notes, WiseHomex.AngelNote
  end
end
