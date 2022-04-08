defmodule BandOfTheWeekWeb.SpotifyLive do
  use BandOfTheWeekWeb, :live_view

  alias BandOfTheWeek.Spotify.AuthClient

  def render(assigns) do
    ~H"""
    <h1 class="text-xl">Spotify Player</h1>
    <h2><%= @username %></h2>
    <p>Access Token - <%= @spotify_access_token %></p>
    <p>Refresh Token - <%= @spotify_refresh_token %></p>
    <button phx-click="play">Play</button>
    <button phx-click="pause">Pause</button>
    """
  end

  def mount(
        _params,
        %{
          "spotify_access_token" => spotify_access_token,
          "spotify_refresh_token" => spotify_refresh_token
        },
        socket
      ) do
    {:ok, res} =
      :get
      |> Finch.build("https://api.spotify.com/v1/me", [
        {"Authorization", "Bearer #{spotify_access_token}"},
        {"Content-Type", "application/json"}
      ])
      |> Finch.request(BandOfTheWeekFinch)

    username =
      res
      |> Map.get(:body)
      |> Jason.decode!()
      |> Map.get("display_name")

    socket =
      socket
      |> assign(:spotify_access_token, spotify_access_token)
      |> assign(:spotify_refresh_token, spotify_refresh_token)
      |> assign(:username, username)

    {:ok, socket}
  end

  def handle_event("play", _session, socket) do
    AuthClient.play(socket.assigns.spotify_access_token)
    {:noreply, socket}
  end

  def handle_event("pause", _session, socket) do
    AuthClient.pause(socket.assigns.spotify_access_token)
    {:noreply, socket}
  end
end
