defmodule Bell.Repo do
  use Ecto.Repo,
    otp_app: :bell,
    adapter: Ecto.Adapters.Postgres
end
