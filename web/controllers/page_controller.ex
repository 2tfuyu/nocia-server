defmodule NociaServer.PageController do
  use NociaServer.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
