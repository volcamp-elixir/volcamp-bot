defmodule Volcamp.Bot.MessageHandler do
  def handle_message("/film" <> _, _chat_id) do
    options = [["action"], ["comedie"], ["aventure"]]

    {"Quel genre ?", options}
  end

  def handle_message("action", chat_id) do
    spawn(fn -> get_and_send_photo(chat_id) end)

    "Je viens de lancer un super algo pour te trouver les 3 meilleurs films"
  end

  def handle_message(_, _) do
    "Pas compris..."
  end

  def get_and_send_photo(chat_id) do
    token = Application.get_env(:volcamp_bot, :token)

    films = Film.Discover.get_films_list_by_genre("action", 3)

    films
    |> Enum.map(fn film ->
      photo_url = Film.Cover.get_cover(film)
      {film, photo_url}
    end)
    |> Enum.map(fn {film, photo_url} ->
      Telegram.Api.request(token, "sendPhoto",
        chat_id: chat_id,
        photo: photo_url,
        caption: film.title
      )
    end)
  end
end
