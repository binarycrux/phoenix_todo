defmodule Todoapp.Tasks do
  import Ecto.Query, warn: false
  alias Todoapp.Repo
  alias Todoapp.Task

  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

# Function to list all tasks for the current user
  def list_tasks(user_id) do
    Repo.all(from t in Task, where: t.user_id == ^user_id)
  end

  # Function to get task by its id and user id
  def get_task!(id, user_id) do
    Repo.get_by!(Task, id: id, user_id: user_id)
  end

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
