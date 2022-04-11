defmodule BandOfTheWeek.Bands.Band do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bands" do
    field :name, :string
    field :spotify_url, :string

    timestamps()
  end

  @doc false
  def changeset(band, attrs) do
    band
    |> cast(attrs, [:name, :spotify_url])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
