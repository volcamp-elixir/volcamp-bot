defmodule Volcamp.Bot.MessageHandler do
  def handle_message("/moviefunny", chat_id) do
    handle_message("/moviecomedy", chat_id)
  end

  def handle_message("/movie" <> genre, chat_id) do
    Movie.Discover.get_movies(genre: genre, size: 3)
    |> Task.async_stream(fn movie ->
      cover = Movie.Cover.get_cover(movie)
      {movie, cover}
    end)
    |> Stream.reject(fn {:ok, {movie, _cover}} ->
      movie.title |> String.contains?("furious")
    end)
    |> Enum.map(fn {:ok, {movie, cover}} ->
      Volcamp.Bot.send_media(cover, movie.title, chat_id)
    end)
  end

  def handle_message(_message, chat_id) do
    Volcamp.Bot.send_text("\\_(°-°)_/", chat_id)
  end
end
