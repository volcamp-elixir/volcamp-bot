defmodule Youtubedl do
  def download(yt_urls, output \\ "/tmp/video.mp4")

  def download(yt_urls, output) when is_list(yt_urls) do
    yt_urls
    |> Stream.map(fn url -> download(url, output) end)
    |> Enum.find(fn
      nil -> false
      _ -> true
    end)
  end

  def download(yt_url, output) do
    case System.cmd("youtube-dl", ["-o", output, "-f", "mp4", yt_url]) do
      {_, 0} -> output
      _ -> nil
    end
  end
end
