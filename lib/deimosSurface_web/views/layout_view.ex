defmodule DeimosSurfaceWeb.LayoutView do
  use DeimosSurfaceWeb, :view

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  # @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}
  def theme_name(%{"theme_name" => theme}), do: theme
  def theme_name(_), do: "deimos-theme-one"
end
