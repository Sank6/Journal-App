defmodule Journal.Repo.Migrations.StringToText do
  use Ecto.Migration

  def change do
    alter table(:entries) do
      modify :body, :text
    end
  end
end
