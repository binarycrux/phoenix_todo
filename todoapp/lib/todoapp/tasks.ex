defmodule Todoapp.Tasks do
  import Ecto.Query, warn: false
  alias Todoapp.Repo
  alias Todoapp.Task

  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

# Function to list all tasks
  def list_tasks do
    Repo.all(Task)
  end

  # Function to get task by ID
  def get_task!(id), do: Repo.get!(Task, id)

  # Function to update task status
  def update_status(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  # Function to handle updating edited task
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

# Function to edit task
def edit_task(%Task{} = task, attrs \\ %{}) do
  Task.changeset(task, attrs)
end

  # Function to delete a task from the db
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end
end
