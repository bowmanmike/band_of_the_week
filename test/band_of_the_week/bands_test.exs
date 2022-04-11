defmodule BandOfTheWeek.BandsTest do
  use BandOfTheWeek.DataCase

  alias BandOfTheWeek.Bands

  describe "bands" do
    alias BandOfTheWeek.Bands.Band

    # import BandOfTheWeek.BandsFixtures

    @invalid_attrs %{name: nil, spotify_url: nil}

    test "list_bands/0 returns all bands" do
      band = insert(:band)
      assert Bands.list_bands() == [band]
    end

    test "get_band!/1 returns the band with given id" do
      band = insert(:band)
      assert Bands.get_band!(band.id) == band
    end

    test "create_band/1 with valid data creates a band" do
      valid_attrs = %{name: "some name", spotify_url: "some spotify_url"}

      assert {:ok, %Band{} = band} = Bands.create_band(valid_attrs)
      assert band.name == "some name"
      assert band.spotify_url == "some spotify_url"
    end

    test "create_band/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bands.create_band(@invalid_attrs)
    end

    test "update_band/2 with valid data updates the band" do
      band = insert(:band)
      update_attrs = %{name: "some updated name", spotify_url: "some updated spotify_url"}

      assert {:ok, %Band{} = band} = Bands.update_band(band, update_attrs)
      assert band.name == "some updated name"
      assert band.spotify_url == "some updated spotify_url"
    end

    test "update_band/2 with invalid data returns error changeset" do
      band = insert(:band)
      assert {:error, %Ecto.Changeset{}} = Bands.update_band(band, @invalid_attrs)
      assert band == Bands.get_band!(band.id)
    end

    test "delete_band/1 deletes the band" do
      band = insert(:band)
      assert {:ok, %Band{}} = Bands.delete_band(band)
      assert_raise Ecto.NoResultsError, fn -> Bands.get_band!(band.id) end
    end

    test "change_band/1 returns a band changeset" do
      band = insert(:band)
      assert %Ecto.Changeset{} = Bands.change_band(band)
    end
  end
end
