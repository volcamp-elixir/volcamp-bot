defmodule Volcamp.Bot.MessageHandler do
  def handle_message("/movie", chat_id) do
    [movie] = Movie.Discover.get_movies()
    Volcamp.Bot.send_text("Si tu dois voir un film aujourd'hui\n#{movie.title}", chat_id)
  end

  def handle_message(_message, chat_id) do
    Volcamp.Bot.send_text("\\_(°-°)_/", chat_id)
  end
end
