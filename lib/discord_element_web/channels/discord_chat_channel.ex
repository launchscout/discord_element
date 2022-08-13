defmodule DiscordElementWeb.DiscordChatChannel do
  use LiveState.Channel, web_module: DiscordElementWeb
  alias Phoenix.PubSub
  alias Nostrum.Api

  @guild_id 553656304154050563

  def init(_socket, _payload, _channel) do
    {:ok, %{messages: []}}
  end

  def handle_event("start_chat", %{"name" => name}, state) do
    {:ok, channel} = Api.create_guild_channel(@guild_id, name: "website visitor #{name}")
    PubSub.subscribe(DiscordElement.PubSub, "messages:#{channel.id}")
    {:noreply, Map.merge(state, %{name: name, channel_id: channel.id})}
  end

  def handle_event("new_message", %{"message" => message}, %{channel_id: channel_id} = state) do
    Api.create_message(channel_id, content: message)
    {:noreply, state}
  end

  def handle_message({:message_created, from, content}, %{messages: messages} = state) do
    {:noreply, Map.put(state, :messages, messages ++ [%{from: from, content: content}])}
  end

end
