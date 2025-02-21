defmodule Todoapp.Tasks do
  import Ecto.Query, warn: false
  alias Todoapp.Repo
  alias Todoapp.Task

  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end
end
