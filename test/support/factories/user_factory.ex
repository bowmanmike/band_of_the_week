defmodule BandOfTheWeek.UserFactory do
  defmacro __using__(_opts) do
    def user_factory do
      %BandOfTheWeek.Accounts.User{
        email: Faker.Internet.email(),
        hashed_password
      }
    end
  end
end
