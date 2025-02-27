defmodule TodoappWeb.TodoController do
  use TodoappWeb, :controller
  alias Todoapp.Task
  alias Todoapp.Tasks

  # Action for rendering add todo page
  def newtodo(conn, _params) do
# Fetching all tasks from the db
tasks = Tasks.list_tasks();
    render(conn, :newtodo, changeset: Task.changeset(%Task{}, %{}), tasks: tasks)
  end

  # Action to create new todo to the database
  def create(conn, %{"task" => task_params}) do
    case Tasks.create_task(task_params) do
      {:ok, _task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: ~p"/")

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset.errors, label: "Changeset errors")
        render(conn, :newtodo, changeset: changeset)
    end
  end

  # Action to toggle status of a task
  def toggle_status(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    new_status = if task.status == "pending", do: "done", else: "pending"

    case Tasks.update_status(task, %{status: new_status}) do
      {:ok, _task} ->
        conn
        |> put_flash(:info, "Task status updated successfully.")
        |> redirect(to: ~p"/")
      {:error, changeset} ->
        IO.inspect(changeset.errors, label: "Update errors")
        conn
        |> put_flash(:error, "Failed to update task status.")
        |> redirect(to: ~p"/")
    end
  end

# Action to handle displaying task edit template
def edit(conn, %{"id" => id}) do
  task = Tasks.get_task!(id)
  changeset = Tasks.edit_task(task)
  render(conn, :edittodo, task: task, changeset: changeset)
end

# Action to handle updating edited task
def update_task(conn, %{"id" => id, "task" => new_task}) do
  task = Tasks.get_task!(id)

  case Tasks.update_task(task, new_task) do
    {:ok, _task} ->
      conn
      |> put_flash(:info, "Task updated successfully.")
      |> redirect(to: ~p"/")
    {:error, changeset} ->
      IO.inspect(changeset.errors, label: "Update errors")
      conn
      |> put_flash(:error, "Failed to update task.")
      |> redirect(to: ~p"/")
  end
end

  # Action to handle task delete
  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)
    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: ~p"/")
  end

end
