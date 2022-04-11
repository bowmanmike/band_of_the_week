defmodule BandOfTheWeek.BandsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BandOfTheWeek.Bands` context.
  """

  @doc """
  Generate a unique band name.
  """
  def unique_band_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a band.
  """
  def band_fixture(attrs \\ %{}) do
    {:ok, band} =
      attrs
      |> Enum.into(%{
        name: unique_band_name(),
        spotify_url: "some spotify_url"
      })
      |> BandOfTheWeek.Bands.create_band()

    band
  end
end
