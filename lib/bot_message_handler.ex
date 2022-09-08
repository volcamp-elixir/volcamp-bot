defmodule Volcamp.Bot.MessageHandler do

  def handle_message("/film" <> _, _chat_id) do
    options = [["action"],["comedie"],["aventure"]]

    {"Quel genre ?", options}
  end

  def handle_message("action", chat_id) do
    #fetch via API
    spawn(fn -> get_and_send_photo('IMAGE_URL', chat_id) end)

    "Cool un film d'action, j'ai trouvé un truc, je t'envoie la photo."
  end

  def handle_message(_, _) do
    "Pas compris..."
  end


  def get_and_send_photo(url, chat_id) do
    :timer.sleep(5000)
    token = Application.get_env(:volcamp_bot, :token)

    #TODO
    #{:ok, resp} = :httpc.request(:get, {url, []}, [], [body_format: :binary])
    #{{_, 200, 'OK'}, _headers, body} = resp

    Telegram.Api.request(token, "sendPhoto", chat_id: chat_id, photo: {:file, "tmp/photo3.jpg"})
  end

end
