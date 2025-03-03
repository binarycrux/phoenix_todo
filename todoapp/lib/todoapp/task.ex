defmodule Todoapp.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :task, :string
    field :status, :string, default: "pending"
    belongs_to :user, Todoapp.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:task, :status, :user_id])
    |> validate_required([:task, :user_id])
  end
end
