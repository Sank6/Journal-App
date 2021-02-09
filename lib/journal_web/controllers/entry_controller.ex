defmodule JournalWeb.EntryController do
  use JournalWeb, :controller

  alias Journal.Timeline
  alias Journal.Timeline.Entry

  def index(conn, _params) do
    entries = Timeline.list_entries()
    render(conn, "index.html", entries: entries)
  end

  def new(conn, _params) do
    changeset = Timeline.change_entry(%Entry{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"entry" => entry_params}) do
    case Timeline.create_entry(entry_params) do
      {:ok, entry} ->
        conn
        |> put_flash(:info, "Entry created successfully.")
        |> redirect(to: Routes.entry_path(conn, :show, entry))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    entry = Timeline.get_entry!(id)
    render(conn, "show.html", entry: entry)
  end

  def edit(conn, %{"id" => id}) do
    entry = Timeline.get_entry!(id)
    changeset = Timeline.change_entry(entry)
    render(conn, "edit.html", entry: entry, changeset: changeset)
  end

  def update(conn, %{"id" => id, "entry" => entry_params}) do
    entry = Timeline.get_entry!(id)

    case Timeline.update_entry(entry, entry_params) do
      {:ok, entry} ->
        conn
        |> put_flash(:info, "Entry updated successfully.")
        |> redirect(to: Routes.entry_path(conn, :show, entry))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", entry: entry, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    entry = Timeline.get_entry!(id)
    {:ok, _entry} = Timeline.delete_entry(entry)

    conn
    |> put_flash(:info, "Entry deleted successfully.")
    |> redirect(to: Routes.entry_path(conn, :index))
  end
end
