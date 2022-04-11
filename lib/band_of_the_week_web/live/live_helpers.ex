defmodule BandOfTheWeekWeb.LiveHelpers do
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  alias Phoenix.LiveView.JS

  @doc """
  Renders a live component inside a modal.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <.modal return_to={Routes.list_index_path(@socket, :index)}>
        <.live_component
          module={BandOfTheWeekWeb.ListLive.FormComponent}
          id={@list.id || :new}
          title={@page_title}
          action={@live_action}
          return_to={Routes.list_index_path(@socket, :index)}
          list: @list
        />
      </.modal>
  """
  def modal(assigns) do
    assigns = assign_new(assigns, :return_to, fn -> nil end)

    ~H"""
    <div
      id="modal"
      class="fixed z-10 left-0 top-0 w-full h-full overflow-auto  bg-black/40 !opacity-100 fade-in"
      phx-remove={hide_modal()}
    >
      <div
        id="modal-content"
        class="p-5 w-4/5 mx-auto my-12 border border-gray-300 bg-white fade-in-scale"
        phx-click-away={JS.dispatch("click", to: "#close")}
        phx-window-keydown={JS.dispatch("click", to: "#close")}
        phx-key="escape"
      >
        <%= if @return_to do %>
          <%= live_patch("✖",
            to: @return_to,
            id: "close",
            class:
              "text-gray-200 p-5 text-2xl font-bold hover::text-black hover:decoration-none hover:cursor-pointer focus:text-black focus:decoration-none focus:cursor-pointer",
            phx_click: hide_modal()
          ) %>
        <% else %>
          <a id="close" href="#" class="phx-modal-close" phx-click={hide_modal()}>✖</a>
        <% end %>

        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  defp hide_modal(js \\ %JS{}) do
    js
    |> JS.hide(to: "#modal", transition: "fade-out")
    |> JS.hide(to: "#modal-content", transition: "fade-out-scale")
  end
end
