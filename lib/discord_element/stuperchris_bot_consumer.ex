defmodule DiscordElement.StuperChrisBotConsumer do
  use Nostrum.Consumer

  alias Phoenix.PubSub

  @bot_id 553671395289071622

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, %{channel_id: channel_id, content: content, author: %{username: username, id: id}}, _ws_state}) do
    from = (if id == @bot_id, do: "you", else: username)
    PubSub.broadcast!(DiscordElement.PubSub, "messages:#{channel_id}", {:message_created, from, content})
  end

  # Default event handler, if you don't include this, your consumer WILL crash if
  # you don't have a method definition for each event type.
  def handle_event(_event) do
    :noop
  end
end
