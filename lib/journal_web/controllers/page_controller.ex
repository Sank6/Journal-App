defmodule JournalWeb.PageController do
  use JournalWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: "/entries")
  end
end
