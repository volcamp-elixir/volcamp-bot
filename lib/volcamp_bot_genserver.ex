defmodule Volcamp.Bot do
  require Logger
  use Telegram.ChatBot

  @impl Telegram.ChatBot
  def init(_chat) do
    {:ok, nil}
  end

  @impl Telegram.ChatBot
  def handle_update(%{"message" => %{"chat" => %{"id" => chat_id}, "text" => text}}, token, _count_state) do

    Telegram.Api.request(token, "sendMessage",
      chat_id: chat_id,
      text: Volcamp.Bot.MessageHandler.handle_message(text)
    )

    {:ok, nil}
  end

  def handle_update(update, _token, _count_state) do
    Logger.info("Unknown update received: #{inspect(update)}")

    {:ok, nil}
  end
end
