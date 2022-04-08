defmodule BandOfTheWeekWeb.AuthorizationController do
  use BandOfTheWeekWeb, :controller

  alias BandOfTheWeek.Spotify.AuthClient

  def authorize(conn, _params) do
    redirect_url = URI.to_string(AuthClient.authorize_url())

    redirect(conn, external: redirect_url)
  end
end
