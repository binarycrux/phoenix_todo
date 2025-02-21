defmodule TodoappWeb.TodoHTML do
  use TodoappWeb, :html
   # Form functionality
   import Phoenix.HTML.Form

  embed_templates "todo_html/*"
end
