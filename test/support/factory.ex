defmodule BandOfTheWeek.Factory do
  use ExMachina.Ecto, repo: BandOfTheWeek.Repo

  use BandOfTheWeek.BandFactory
  use BandOfTheWeek.UserFactory
end
