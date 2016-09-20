defmodule SoloProject.PageController do
  use SoloProject.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
