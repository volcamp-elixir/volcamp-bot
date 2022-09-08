defmodule Movie do
  defstruct [:title, :movie_db_id, :cover]
end

defmodule Movie.Discover do
  @api_url "https://api.themoviedb.org"
  @api_key Application.compile_env(:volcamp_bot, :themoviedb_key)
  @cover_url "https://image.tmdb.org/t/p/w300/"

  @discover_endpoint "/3/discover/movie"
  @genres %{
    "action" => 28,
    "adventure" => 12,
    "animation" => 16,
    "comedy" => 35,
    "crime" => 80,
    "documentary" => 99,
    "drama" => 18,
    "family" => 10751,
    "fantasy" => 14,
    "history" => 36,
    "horror" => 27,
    "music" => 10402,
    "mystery" => 9648,
    "romance" => 10749,
    "thriller" => 53,
    "war" => 10752,
    "western" => 37
  }

  def get_movies(opts \\ []) do
    size = opts[:size] || 1
    genre = opts[:genre] || ""

    {status_genre, genre} =
      case genre && String.downcase(genre) do
        genre = "" -> {:ok, ""}
        genre when is_map_key(@genres, genre) -> {:ok, "with_genres=#{@genres[genre]}"}
        _ -> {:error, nil}
      end

    url =
      "#{@api_url}#{@discover_endpoint}?api_key=#{@api_key}&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=#{:rand.uniform(10)}&with_watch_monetization_types=flatrate&#{genre}"

    {:ok, resp} = :httpc.request(:get, {url, []}, [], [])
    {{_, 200, 'OK'}, _headers, body} = resp

    (body |> Jason.decode!())["results"]
    |> Enum.take_random(size)
    |> Enum.map(
      &%Movie{
        title: (status_genre == :ok && &1["title"]) || "Catégorie Inconnue",
        movie_db_id: &1["id"],
        cover:
          (status_genre == :ok && "#{@cover_url}#{&1["poster_path"]}") ||
            "https://www.meme-arsenal.com/memes/c9e6371faa3b57eaee1d35595ca8e910.jpg"
      }
    )
  end
end

defmodule Movie.Cover do
  def get_cover(%Movie{} = movie) do
    :timer.sleep(2_000)

    {:ok, {_, _, body}} = :httpc.request(movie.cover)

    cover_path = "/tmp/volcamp/#{movie.title}.jpg"

    File.mkdir_p!(Path.dirname(cover_path))
    File.write!("/tmp/volcamp/#{movie.title}.jpg", body)

    cover_path
  end
end
