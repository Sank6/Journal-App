defmodule Journal.Timeline.Entry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entries" do
    field :body, :string
    field :feeling, :string
    field :image, :string
    field :time, :utc_datetime_usec, default: DateTime.utc_now()
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:body, :feeling, :image, :title])
    |> validate_required([:body, :feeling, :title])
    |> validate_length(:body, min: 10)
  end
end
