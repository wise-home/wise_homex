defmodule WiseHomex.MessageReport.Event do
  @moduledoc """
  Embedded type under MessageReport. This has a custom Ecto type, since it is rendered as a length-two list from the
  API.
  """

  use WiseHomex.BaseModel
  use Ecto.Type

  alias Ecto.Changeset

  @primary_key false

  embedded_schema do
    field :description, :string
    field :time, :utc_datetime
  end

  @impl Ecto.Type
  def cast(%__MODULE__{} = event), do: {:ok, event}

  def cast([description, time]) do
    %__MODULE__{}
    |> Changeset.cast(%{description: description, time: time}, [:description, :time])
    |> case do
      %{valid?: true} = changeset -> {:ok, Changeset.apply_changes(changeset)}
      %{valid?: false} -> :error
    end
  end

  def cast(_), do: :error

  @impl Ecto.Type
  def dump(_), do: {:ok, nil}
  @impl Ecto.Type
  def load(_), do: {:ok, nil}
  @impl Ecto.Type
  def type, do: nil
end
