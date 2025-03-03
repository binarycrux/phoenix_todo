defmodule TodoappWeb.TodoController do
  use TodoappWeb, :controller
  alias Todoapp.Task
  alias Todoapp.Tasks

  plug :fetch_current_user

  defp fetch_current_user(conn, _opts) do
    user = conn.assigns.current_user
    assign(conn, :current_user, user)
  end

  def index(conn, _params) do
    render(conn, :index)
  end
  # Action for rendering add todo page
  def newtodo(conn, _params) do
  user_id = conn.assigns.current_user.id
# Fetching all user tasks from the db
  tasks = Tasks.list_tasks(user_id);
  render(conn, :newtodo, changeset: Task.changeset(%Task{}, %{}), tasks: tasks)
  end

  # Action to create new todo to the database
  def create(conn, %{"task" => task_params}) do
    user_id = conn.assigns.current_user.id
    task_params = Map.put(task_params, "user_id", user_id)

    case Tasks.create_task(task_params) do
      {:ok, _task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: ~p"/todo")

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset.errors, label: "Changeset errors")
        render(conn, :newtodo, changeset: changeset)
    end
  end

  # Action to toggle status of a task
  def toggle_status(conn, %{"id" => id}) do
    user_id = conn.assigns.current_user.id
    task = Tasks.get_task!(id, user_id)
    new_status = if task.status == "pending", do: "done", else: "pending"

    case Tasks.update_status(task, %{status: new_status}) do
      {:ok, _task} ->
        conn
        |> put_flash(:info, "Task status updated successfully.")
        |> redirect(to: ~p"/todo")
      {:error, changeset} ->
        IO.inspect(changeset.errors, label: "Update errors")
        conn
        |> put_flash(:error, "Failed to update task status.")
        |> redirect(to: ~p"/todo")
    end
  end

# Action to handle displaying task edit template
def edit(conn, %{"id" => id}) do
  user_id = conn.assigns.current_user.id
    task = Tasks.get_task!(id, user_id)
    changeset = Task.changeset(task, %{})
    render(conn, :edittodo, task: task, changeset: changeset)
end

# Action to handle updating edited task
def update_task(conn, %{"id" => id, "task" => new_task}) do
  user_id = conn.assigns.current_user.id
  task = Tasks.get_task!(id, user_id)

  case Tasks.update_task(task, new_task) do
    {:ok, _task} ->
      conn
      |> put_flash(:info, "Task updated successfully.")
      |> redirect(to: ~p"/todo")
    {:error, changeset} ->
      render(conn, :edittodo, task: task, changeset: changeset)
  end
end

  # Action to handle task delete
  def delete(conn, %{"id" => id}) do
    user_id = conn.assigns.current_user.id
    task = Tasks.get_task!(id, user_id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: ~p"/todo")
  end

end
