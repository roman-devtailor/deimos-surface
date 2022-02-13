defmodule DeimosSurface.Components.Button do
  @moduledoc false

  use Surface.Component

  prop variant, :string, values: ["primary", "secondary", "warrning", "success", "info"], default: "primary"
  prop size, :string, values: ["small", "medium", "large"], default: "medium"
  prop disabled, :boolean
  prop class, :string

  prop on_click, :event
  prop value, :any

  slot default

  def render(assigns) do
    ~F"""
    <button
      class={
        "btn",
        "btn--sm": @size == "small",
        "btn--lg": @size == "large",
        "btn--secondary": @variant == "secondary",
        "btn--info": @variant == "info",
        "btn--warrning": @variant == "warrning",
        "btn--success": @variant == "success",
      }
      disabled={@disabled}
      :on-click={@on_click}
      value={@value}
    >
      <#slot />
    </button>
    """
  end
end
