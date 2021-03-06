defmodule BandOfTheWeekWeb.BandLive.Index do
  use BandOfTheWeekWeb, :live_view

  alias BandOfTheWeek.Bands
  alias BandOfTheWeek.Bands.Band

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :bands, list_bands())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Band")
    |> assign(:band, Bands.get_band!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Band")
    |> assign(:band, %Band{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bands")
    |> assign(:band, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    band = Bands.get_band!(id)
    {:ok, _} = Bands.delete_band(band)

    socket =
      socket
      |> put_flash(:info, "Successfully deleted #{band.name}")
      |> assign(:bands, list_bands())

    {:noreply, socket}
  end

  defp list_bands do
    Bands.list_bands()
  end
end
