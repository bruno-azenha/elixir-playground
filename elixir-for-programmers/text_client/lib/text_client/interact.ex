defmodule TextClient.Interact do

  alias TextClient.{Player, State}

  def start() do
    Hangman.new_game()
    |> set_up_state()
    |> Player.play()
  end

  defp set_up_state(game) do
    %State{
      game_service: game,
      tally: Hangman.tally(game)
    }
  end

end
