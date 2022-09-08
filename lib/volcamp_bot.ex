defmodule Volcamp.Bot do
  require Logger
  use Telegram.Bot
  @token Application.get_env(:volcamp_bot, :token)
  @impl Telegram.Bot
  def init(_chat) do
    {:ok, nil}
  end
  @impl Telegram.Bot
  def handle_update(%{"message" => %{"chat" => %{"id" => chat_id}, "text" => text}}, token) do
    Volcamp.Bot.MessageHandler.handle_message(text, chat_id)
  end
  def handle_update(update, _token) do
    Logger.debug("Unknown update received: #{inspect(update)}")
    :ok
  end
  def send_text(message, chat_id) do
    Telegram.Api.request(@token, "sendMessage", chat_id: chat_id, text: message)
  end

  def send_media(cover, caption, chat_id) do
    Telegram.Api.request(@token, "sendPhoto",
      chat_id: chat_id,
      photo: {:file, cover},
      caption: caption)
  end
end
