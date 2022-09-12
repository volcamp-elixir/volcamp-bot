defmodule Trailer do
  def urls(movie) do
    case System.cmd("movie-trailer", [
           "-m",
           "-k",
           Application.get_env(:volcamp_bot, :themoviedb_key),
           movie
         ]) do
      {"null\n", 0} -> {:error, :not_found}
      {yt_url, 0} -> {:ok, yt_url |> String.replace("'", "\"") |> Jason.decode!()}
    end
  end
end
