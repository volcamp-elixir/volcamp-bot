defmodule Volcamp.Bot.MessageHandler do
  def handle_message(_message, chat_id) do
    Volcamp.Bot.send_text("\\_(°-°)_/", chat_id)
  end
end
