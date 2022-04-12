defmodule BandOfTheWeekWeb.LayoutView do
  use BandOfTheWeekWeb, :view

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}

  def flash_color_for_level("info"), do: "green"
  def flash_color_for_level("warning"), do: "yellow"
  def flash_color_for_level("error"), do: "red"
end
