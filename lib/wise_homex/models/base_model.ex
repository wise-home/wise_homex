defmodule WiseHomex.BaseModel do
  @moduledoc """
  Defines the base settings for WiseHomex models. We never use primary keys since we
  do not have a database. Furthermore all ids should be defined as :string fields
  but we can't do that in this module.
  """

  defmacro __using__([]) do
    quote do
      @type t :: %__MODULE__{}

      use Ecto.Schema
      @primary_key {:id, :string, autogenerate: false}
    end
  end
end
