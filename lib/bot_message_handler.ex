defmodule Volcamp.Bot.MessageHandler do

  def handle_message("/film" <> _, _chat_id) do
    options = [["action"],["comedie"],["aventure"]]

    {"Quel genre ?", options}
  end

  def handle_message("action", chat_id) do
    #fetch via API
    spawn(fn ->
      [movie_title] = get_films_list_by_genre("action",1)
      case Trailer.urls(movie_title) do
                    {:ok, urls } -> Youtubedl.download(urls, "/tmp/#{movie_title}.mp4") |> send_video(chat_id)
        {:error, _} -> get_and_send_photo('IMAGE_URL', chat_id)
      end end)

    "Cool un film d'action, j'ai trouvé un truc, je t'envoie la photo."
  end

  def get_films_list_by_genre("action", size \\ 1) do
    id = %{"action" => 28}["action"]
    themoviedb_key = Application.get_env(:volcamp_bot, :themoviedb_key)
    url = "https://api.themoviedb.org/3/discover/movie?api_key=#{themoviedb_key}&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=#{id}&with_watch_monetization_types=flatrate"
    {:ok, resp} = :httpc.request(:get, {url, []}, [], [])
    {{_, 200, 'OK'}, _headers, body} = resp
    ( body |> Jason.decode!() )["results"] |> Enum.take(size) |> Enum.map(&(&1["title"]))
  end

  def handle_message(_, _) do
    "Pas compris..."
  end

  def send_video(file, chat_id) do
    IO.inspect(file, label: "file")
    token = Application.get_env(:volcamp_bot, :token)
    Telegram.Api.request(token, "sendVideo", chat_id: chat_id, video: {:file,file})
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
