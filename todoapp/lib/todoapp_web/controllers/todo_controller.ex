defmodule TodoappWeb.TodoController do
  use TodoappWeb, :controller
  alias Todoapp.Task
  alias Todoapp.Tasks

  # Action for rendering add todo page
  def newtodo(conn, _params) do
    # Rendering the index template
    render(conn, :newtodo, changeset: Task.changeset(%Task{}, %{}))
  end

  # Action for rendering current page user
  def user(conn, %{"user" => user}) do
    render(conn, :user, user: user, changeset: Task.changeset(%Task{}, %{}))
  end

  def create(conn, %{"task" => task_params}) do
    case Tasks.create_task(task_params) do
      {:ok, _task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(conn, to: ~p"/newtodo")

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset.errors, label: "Changeset errors")
        render(conn, :newtodo, changeset: changeset)
    end
  end
end
