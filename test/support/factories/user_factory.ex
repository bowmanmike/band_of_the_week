defmodule BandOfTheWeek.UserFactory do
  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %BandOfTheWeek.Accounts.User{
          email: Faker.Internet.email(),
          password: "test_password_1",
          hashed_password: "$2b$12$tx.U0eAdCXl0P.48qZyvqehXybAfSMO8ULnbhmzbwmJoI58LuIx9G"
        }
      end
    end
  end
end
