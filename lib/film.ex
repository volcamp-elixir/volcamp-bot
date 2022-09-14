defmodule Film do
  defstruct [:title, :movie_db_id, :cover]
end

defmodule Film.Discover do
  @api_url "https://api.themoviedb.org"
  @api_key Application.compile_env(:volcamp_bot, :themoviedb_key)

  @discover_endpoint "/3/discover/movie"

  def get_films_list_by_genre("action", size \\ 1) do
    id = %{"action" => 28}["action"]

    url =
      "#{@api_url}#{@discover_endpoint}?api_key=#{@api_key}&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=#{id}&with_watch_monetization_types=flatrate"

    {:ok, resp} = :httpc.request(:get, {url, []}, [], [])
    {{_, 200, 'OK'}, _headers, body} = resp

    (body |> Jason.decode!())["results"]
    |> Enum.take_random(size)
    |> Enum.map(&%Film{title: &1["title"], movie_db_id: &1["id"], cover: &1["poster_path"]})
  end
end

defmodule Film.Cover do
  @api_url "https://image.tmdb.org/t/p/w500/"
  def get_cover(%Film{} = film) do
    # :timer.sleep(10_000)
    "#{@api_url}#{film.cover}"
  end
end
