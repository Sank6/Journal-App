defmodule JournalWeb.EntryController do
  use JournalWeb, :controller

  alias Journal.Timeline
  alias Journal.Timeline.Entry

  def index(conn, params) do
    entries = Timeline.list_entries(params)
    render(conn, "index.html", entries: entries)
  end

  def new(conn, _params) do
    changeset = Timeline.change_entry(%Entry{})
    access_key = Application.get_env(:journal, JournalWeb.Endpoint)[:unsplash_access_key]
    %HTTPoison.Response{status_code: 200, body: body} = HTTPoison.get!("https://api.unsplash.com/photos?client_id=#{access_key}")
    {:ok, images} = Jason.decode(body)
    render(conn, "new.html", changeset: changeset, images: images)
  end

  def create(conn, %{"entry" => entry_params}) do
    access_key = Application.get_env(:journal, JournalWeb.Endpoint)[:unsplash_access_key]
    %HTTPoison.Response{status_code: 200, body: body} = HTTPoison.get!("https://api.unsplash.com/photos?client_id=#{access_key}")
    {:ok, images} = Jason.decode(body)
    case Timeline.create_entry(entry_params) do
      {:ok, entry} ->
        conn
        |> put_flash(:info, "Entry created successfully.")
        |> redirect(to: Routes.entry_path(conn, :show, entry))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, images: images)
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
