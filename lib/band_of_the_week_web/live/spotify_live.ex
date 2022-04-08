defmodule BandOfTheWeekWeb.SpotifyLive do
  use BandOfTheWeekWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1 class="text-xl">Spotify Player</h1>
    <div id="spotify-player" phx-hook="InitSpotifyPlayer"></div>
    """
  end
end
