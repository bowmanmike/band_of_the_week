defmodule BandOfTheWeek.UserFactory do
  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %BandOfTheWeek.Accounts.User{
          email: Faker.Internet.email(),
          hashed_password: ""
        }
      end
    end
  end
end
