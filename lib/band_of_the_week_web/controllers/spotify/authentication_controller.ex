defmodule BandOfTheWeekWeb.Spotify.AuthenticationController do
  use BandOfTheWeekWeb, :controller

  alias BandOfTheWeek.Spotify.AuthClient

  def authenticate(conn, %{"code" => code} = params) do
    {:ok, response} = AuthClient.authenticate(code)

    body = Jason.decode!(response.body)

    conn
    |> put_session(:spotify_access_token, body["access_token"])
    |> put_session(:spotify_refresh_token, body["refresh_token"])
    |> redirect(to: "/spotify")
  end
end
