defmodule DeimosSurfaceWeb.Pages.Home do
  use DeimosSurfaceWeb, :live_view

  alias DeimosSurface.Components.Button

  def mount(params, _session, socket) do
    {:ok,
     assign(socket, theme_name: params["theme_name"] || "deimos-theme-one", active_page: __MODULE__)}
  end

  def render(assigns) do
    ~F"""
      <div>
        <div class="row">
          <div>
            <Button on_click="switch_theme_one">Switch to Theme One</Button>
            <Button on_click="switch_theme_two" variant="secondary">Switch to Theme Two</Button>
          </div>
        </div>
        <div class="row">
          <Button>Primary</Button>
          <Button variant="secondary">Secondary</Button>
          <Button variant="info">Secondary</Button>
          <Button variant="warrning">Secondary</Button>
          <Button variant="success">Secondary</Button>
        </div>
        <div class="row">
          <Button size="small">Small</Button>
          <Button>Medium</Button>
          <Button size="large">Large</Button>
        </div>
      </div>
    """
  end

  def handle_event("switch_theme_one", _props, socket) do
    %{active_page: active_page} = socket.assigns
    new_path = generate_path(socket, active_page, 'one')
    {:noreply, redirect(socket, to: new_path)}
  end

  def handle_event("switch_theme_two", _props, socket) do
    %{active_page: active_page} = socket.assigns
    new_path = generate_path(socket, active_page, 'two')
    {:noreply, redirect(socket, to: new_path)}
  end

  defp generate_path(socket, active_page, theme) do
    theme_name = "deimos-theme-#{if theme == 'one', do: "one", else: "two"}"
    Routes.live_path(socket, active_page, theme_name, %{})
  end
end
