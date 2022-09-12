defmodule Volcamp.Bot.MessageHandler do

  def handle_message("/film" <> _, _chat_id) do
    options = [["action"],["comedie"],["aventure"]]

    {"Quel genre ?", options}
  end

  def handle_message("action", chat_id) do

    get_and_send_photo(chat_id)

    "Voici le film que je peux te proposer"
  end

  def handle_message(_, _) do
    "Pas compris..."
  end


  def get_and_send_photo(chat_id) do
    token = Application.get_env(:volcamp_bot, :token)

    [ film ] = Film.Discover.get_films_list_by_genre("action", 1)
    photo_url = Film.Cover.get_cover(film)

    Telegram.Api.request(token, "sendPhoto", chat_id: chat_id, photo: photo_url, caption: film.title)
  end
end
