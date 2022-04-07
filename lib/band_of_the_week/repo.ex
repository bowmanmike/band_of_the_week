defmodule BandOfTheWeek.Repo do
  use Ecto.Repo,
    otp_app: :band_of_the_week,
    adapter: Ecto.Adapters.Postgres
end
