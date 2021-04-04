defmodule NouRau.Repo do
  use Ecto.Repo,
    otp_app: :nou_rau,
    adapter: Ecto.Adapters.Postgres
end
