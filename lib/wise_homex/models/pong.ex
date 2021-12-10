defmodule WiseHomex.Pong do
  @moduledoc """
  A response from the ping endpoint
  """

  use WiseHomex.BaseModel

  embedded_schema do
    field :message, :string
    field :version, :string
    field :tag, :string
    belongs_to :user, WiseHomex.User
    belongs_to :account, WiseHomex.Account
  end
end
