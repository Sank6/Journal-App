defmodule Journal.Repo do
  use Ecto.Repo,
    otp_app: :journal,
    adapter: Ecto.Adapters.Postgres
end
