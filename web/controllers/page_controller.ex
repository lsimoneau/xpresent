defmodule Xpresent.PageController do
  use Xpresent.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
