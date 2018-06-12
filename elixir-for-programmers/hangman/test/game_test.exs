defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new_game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
    for letter <- game.letters do
      assert String.match?(letter, ~r/[a-z]/)
    end
  end

  test "state isn't changed for :won or :lost game" do
    for state <- [ :won, :lost ] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert ^game = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter is not already used" do
    game = Game.new_game()
    game = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurrence of letter is already used" do
    game = Game.new_game()
    game = Game.make_move(game, "x")
    assert game.game_state != :already_used
    game = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("potato")
    game = Game.make_move(game, "p")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do
    game = Game.new_game("potato")
    game = Game.make_move(game, "p")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    game = Game.make_move(game, "o")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    game = Game.make_move(game, "t")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
    game = Game.make_move(game, "a")
    assert game.game_state == :won
    assert game.turns_left == 7
  end

  test "bad guess is recognized" do
    game = Game.new_game("wibble")
    game = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "lost game is recognized" do
    game = Game.new_game("wibble")
    game = Game.make_move(game, "a")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
    game = Game.make_move(game, "c")
    assert game.game_state == :bad_guess
    assert game.turns_left == 5
    game = Game.make_move(game, "d")
    assert game.game_state == :bad_guess
    assert game.turns_left == 4
    game = Game.make_move(game, "f")
    assert game.game_state == :bad_guess
    assert game.turns_left == 3
    game = Game.make_move(game, "g")
    assert game.game_state == :bad_guess
    assert game.turns_left == 2
    game = Game.make_move(game, "h")
    assert game.game_state == :bad_guess
    assert game.turns_left == 1
    game = Game.make_move(game, "j")
    assert game.game_state == :lost
  end

  test "won game is recognized simplified" do
    moves = [
      {"w", :good_guess},
      {"i", :good_guess},
      {"b", :good_guess},
      {"l", :good_guess},
      {"e", :won}
    ]

    game = Game.new_game("wibble")
    Enum.reduce(moves, game, fn({guess, state}, game) ->
      game = Game.make_move(game, guess)
      assert game.game_state == state
      game
    end)
  end

  test "guess is single lowercase ASCII character" do
    game = Game.new_game("wibble")
    game = Game.make_move(game, "á")
    assert game.game_state == :invalid_guess
    game = Game.make_move(game, "%")
    assert game.game_state == :invalid_guess
  end

end
