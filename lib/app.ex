defmodule Volcamp.App do
  use Application

  @token Application.get_env(:volcamp_bot, :token)

  def start(_type, _args) do
    {:ok, _} =
      Supervisor.start_link(
        [{Telegram.Poller, bots: [{Volcamp.Bot, token: @token, max_bot_concurrency: 1_000}]}],
        strategy: :one_for_one
      )
  end

end
