defmodule BandOfTheWeek.Repo.Migrations.CreateBands do
  use Ecto.Migration

  def change do
    create table(:bands) do
      add :name, :string, null: false
      add :spotify_url, :string

      timestamps()
    end

    create unique_index(:bands, [:name])
  end
end
