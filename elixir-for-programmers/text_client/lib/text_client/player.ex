defmodule TextClient.Player do

  alias TextClient.{State, Summary, Prompter, Mover}

  # won, lost, good_guess, bad_guess, already_used, initializing, invalid_guess
  def play(%State{tally: %{game_state: :won}}) do
    exit_with_message("You WON!")
    exit(:normal)
  end

  def play(%State{tally: %{game_state: :lost}}) do
    exit_with_message("Sorry, you lost")
  end

  def play(game = %State{tally: %{game_state: :good_guess}}) do
    continue_with_message(game, "Good guess!")
  end

  def play(game = %State{tally: %{game_state: :bad_guess}}) do
    continue_with_message(game, "Sorry, that isn't in the word")
  end

  def play(game) do
    continue(game)
  end

  def continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  def make_move(game) do
    game
  end

  defp continue_with_message(game, message) do
    IO.puts(message)
    continue(game)
  end

  defp exit_with_message(message) do
    IO.puts(message)
    exit(:normal)
  end
end
