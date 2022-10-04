defmodule Volcamp.Bot.MessageHandler do
  def handle_message("/movie" <> genre, chat_id) do
    [movie] = Movie.Discover.get_movies(genre: genre)
    cover = Movie.Cover.get_cover(movie)
    Volcamp.Bot.send_media(cover, movie.title, chat_id)
  end

  def handle_message(_message, chat_id) do
    Volcamp.Bot.send_text("\\_(°-°)_/", chat_id)
  end
end
