defmodule Todoapp.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :task, :string
    field :status, :string, default: "pending"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:task])
    |> validate_required([:task])
    |> put_change(:status, "pending")
  end
end
