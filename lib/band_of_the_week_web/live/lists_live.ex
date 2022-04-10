defmodule BandOfTheWeekWeb.ListsLive do
  use BandOfTheWeekWeb, :live_view

  def mount(_params, %{"user_token" => user_token}, socket) do
    {:ok, assign(socket, :user_token, user_token)}
  end
end
