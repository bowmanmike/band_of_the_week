defmodule BandOfTheWeek.Spotify.AuthClient do
  @config Application.get_env(:band_of_the_week, :spotify)
  @auth_url "accounts.spotify.com"

  def authenticate(code) do
    :post
    |> Finch.build(
      authenticate_url() |> URI.to_string(),
      [
        {"Authorization", "Basic #{encoded_auth_token()}"},
        {"Content-Type", "application/x-www-form-urlencoded"}
      ],
      %{
        grant_type: "authorization_code",
        code: code,
        redirect_uri: Application.get_env(:band_of_the_week, :spotify)[:callback_url]
      }
      |> URI.encode_query(:www_form)
    )
    |> Finch.request(BandOfTheWeekFinch)
    |> IO.inspect()
  end

  def play(token) do
    :put
    |> Finch.build("https://api.spotify.com/v1/me/player/play", headers(token), "{}")
    |> IO.inspect()
    |> Finch.request(BandOfTheWeekFinch)
  end

  def pause(token) do
    :put
    |> Finch.build("https://api.spotify.com/v1/me/player/pause", headers(token), "")
    |> Finch.request(BandOfTheWeekFinch)
  end

  def refresh do
  end

  def authorize_url do
    %URI{
      scheme: "https",
      host: @auth_url,
      path: "/authorize",
      query:
        URI.encode_query(
          client_id: client_id(),
          redirect_uri: callback_url(),
          scope: scopes(),
          response_type: "code"
        )
    }
  end

  def authenticate_url do
    %URI{
      scheme: "https",
      host: @auth_url,
      path: "/api/token"
    }
  end

  def secure_random_string do
    symbols = '0123456789abcdefghijklm'
    symbol_count = Enum.count(symbols)

    for _ <- 1..16, into: "" do
      <<Enum.at(symbols, :rand.uniform(symbol_count))>>
    end
  end

  defp encoded_auth_token do
    Base.encode64("#{client_id()}:#{client_secret()}")
  end

  defp headers(token) do
    [
      {"Authorization", "Bearer #{token}"},
      {"Content-Type", "application/json"}
    ]
  end

  defp client_id, do: @config[:client_id]
  defp client_secret, do: @config[:client_secret]
  defp callback_url, do: @config[:callback_url]
  defp scopes, do: @config[:scopes] |> Enum.join(" ")
end
