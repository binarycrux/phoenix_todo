defmodule Todoapp.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :task, :string
      add :status, :string

      timestamps(type: :utc_datetime)
    end
  end
end
