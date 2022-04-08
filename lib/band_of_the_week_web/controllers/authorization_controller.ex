defmodule BandOfTheWeekWeb.AuthorizationController do
  use BandOfTheWeekWeb, :controller

  def authorize(conn, _params) do
    redirect(conn, external: auth_url())
  end

  defp auth_url do
    %URI{
      host: "accounts.spotify.com",
      path: "/authorize",
      scheme: "https",
      query: URI.encode_query(
        client_id: spotify_client_id(),
        client_secret: spotify_client_secret(),
        redirect_uri: spotify_callback_url(),
        scopes: spotify_scopes(),
        response_type: "code"
      )
    } |> URI.to_string()
  end

  defp spotify_client_id do
    Application.get_env(:band_of_the_week, :spotify)[:client_id]
  end

  defp spotify_client_secret do
    Application.get_env(:band_of_the_week, :spotify)[:client_secret]
  end

  defp spotify_callback_url do
    Application.get_env(:band_of_the_week, :spotify)[:callback_url]
  end

  defp spotify_scopes do
    Application.get_env(:band_of_the_week, :spotify)[:scopes] |> Enum.join(" ")
  end
end
