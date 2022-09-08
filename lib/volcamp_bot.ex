defmodule Volcamp.Bot do
  require Logger
  use Telegram.Bot

  @impl Telegram.Bot
  def init(_chat) do
    {:ok, nil}
  end

  @impl Telegram.Bot
  def handle_update(%{"message" => %{"chat" => %{"id" => chat_id}, "text" => text}}, token) do

    case Volcamp.Bot.MessageHandler.handle_message(text, chat_id) do
      {question_text, options} ->
        keyboard_markup = %{one_time_keyboard: true, keyboard: options}
        Telegram.Api.request(token, "sendMessage", chat_id: chat_id, text: question_text, reply_markup: {:json, keyboard_markup})

      answer_text ->
        Telegram.Api.request(token, "sendMessage", chat_id: chat_id, text: answer_text)

    end

    :ok
  end

  def handle_update(update, _token) do
    Logger.info("Unknown update received: #{inspect(update)}")

    :ok
  end
end
