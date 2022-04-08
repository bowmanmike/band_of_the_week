defmodule BandOfTheWeekWeb.AuthenticationController do
  use BandOfTheWeekWeb, :controller

  def authenticate(_conn, %{"code" => code}) do
    {:ok, response} =
      HTTPoison.post(auth_url(), request_body(code),
        Authorization: "Basic #{encoded_auth_token()}",
        "Content-Type": "application/x-www-form-urlencoded"
      )

    access_token = response.body |> Jason.decode!() |> Map.get("access_token")

    HTTPoison.get("https://api.spotify.com/v1/tracks/2TpxZ7JUBn3uw46aR7qd6V",
      Authorization: "Bearer #{access_token}"
    )

    require IEx
    IEx.pry()
  end

  defp auth_url do
    %URI{
      host: "accounts.spotify.com",
      path: "/api/token",
      scheme: "https"
    }
    |> URI.to_string()
  end

  defp request_body(token) do
    %{
      grant_type: "authorization_code",
      code: token,
      redirect_uri: Application.get_env(:band_of_the_week, :spotify)[:callback_url]
    }
    |> URI.encode_query(:www_form)
  end

  defp encoded_auth_token do
    Base.encode64("#{spotify_client_id()}:#{spotify_client_secret()}")
  end

  defp spotify_client_id do
    Application.get_env(:band_of_the_week, :spotify)[:client_id]
  end

  defp spotify_client_secret do
    Application.get_env(:band_of_the_week, :spotify)[:client_secret]
  end
end
