defmodule DiscordElementWeb.PageController do
  use DiscordElementWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
