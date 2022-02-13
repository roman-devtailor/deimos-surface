defmodule DeimosSurfaceWeb.PageController do
  use DeimosSurfaceWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
