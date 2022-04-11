defmodule BandOfTheWeek.BandFactory do
  defmacro __using__(_opts) do
    quote do
      def band_factory do
        %BandOfTheWeek.Bands.Band{
          name: Faker.Lorem.words() |> Enum.join(" "),
          spotify_url: Faker.Internet.url()
        }
      end
    end
  end
end
