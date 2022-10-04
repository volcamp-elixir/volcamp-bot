defmodule Volcamp.Bot.MessageHandler do
  def handle_message("/moviefunny", chat_id) do
    handle_message("/moviecomedy", chat_id)
  end

  def handle_message("/movie" <> genre, chat_id) do
    Movie.Discover.get_movies(genre: genre, size: 3)
    |> Stream.map(fn movie ->
      cover = Movie.Cover.get_cover(movie)
      {cover, movie}
    end)
    |> Enum.map(fn {cover, movie} ->
      Volcamp.Bot.send_media(cover, movie.title, chat_id)
    end)
  end

  def handle_message(_message, chat_id) do
    Volcamp.Bot.send_text("\\_(°-°)_/", chat_id)
  end
end
