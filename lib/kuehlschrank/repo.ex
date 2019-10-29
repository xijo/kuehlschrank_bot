defmodule Kuehlschrank.Repo do
  use Ecto.Repo,
    otp_app: :kuehlschrank,
    adapter: Ecto.Adapters.Postgres
end
