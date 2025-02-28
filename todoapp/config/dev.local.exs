import Config

  # Configure your database
config :todoapp, Todoapp.Repo,
username: "postgres",
password: "Post@localhost127!",
hostname: "localhost",
database: "todoapp_dev",
stacktrace: true,
show_sensitive_data_on_connection_error: true,
pool_size: 10
