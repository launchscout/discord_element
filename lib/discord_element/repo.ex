defmodule DiscordElement.Repo do
  use Ecto.Repo,
    otp_app: :discord_element,
    adapter: Ecto.Adapters.Postgres
end
