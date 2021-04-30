# frozen_string_literal: true

# It's the Rules module
module Rules
  private

  def display_rules
    new_screen
    print rules_full
    pause_game
  end

  def rules_full
    <<~HEREDOC
      .
        How To Play
        ------------------------------------------------------------
        Step 1:
        The -Code Maker- enters a code.
        The code is 4 colored pegs, made from a choice of 6 different colors.
        Repeated colors are allowed.
        ------------------------------------------------------------
        Step 2:
        The -Code Breaker- then guesses the secret code.
        They get, by default, 12 guesses.
        After each guess, feedback is provided on the right side of the board.
        Second last column - Color & position is correct for a peg.
        Last column - Color is correct, but the peg is in the wrong position.
        ------------------------------------------------------------
        Step 3:
        Have fun crushing your enemies...at Mastermind!
        ------------------------------------------------------------
        If further information is need, consult your local search engine.
        Additionally, copy/follow this link to Wikipedia.
        https://en.wikipedia.org/wiki/Mastermind_(board_game)
        ------------------------------------------------------------
        Happy Gaming
      .
    HEREDOC
  end
end
