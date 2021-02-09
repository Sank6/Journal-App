defmodule Journal.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :body, :string
      add :time, :utc_datetime
      add :feeling, :string
      add :image, :string
      add :title, :string

      timestamps()
    end

  end
end
