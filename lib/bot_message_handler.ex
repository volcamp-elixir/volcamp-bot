defmodule Volcamp.Bot.MessageHandler do

  def handle_message(message) do
    if(String.contains?(message, "soleil")) do
      "La Bretagne bien sûr !"
    else
      "Débrouille toi !"
    end
  end

end
