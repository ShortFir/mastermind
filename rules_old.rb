# frozen_string_literal: true

# It's the Rules module
module Rules
  private

  def display_rules
    new_screen
    rules_title
    rules_step1
    rules_step2
    rules_step3
    rules_step_end
    pause_game
  end

  def nls
    # newline, spaces
    "\n  "
  end

  def rules_title
    print nls, 'How To Play'
    rules_div
  end

  def rules_div
    print nls, '----------------------------------------' # 40
  end

  def rules_step1
    print nls, 'Step 1:'
    print nls, 'The -Code Maker- enters a code.'
    print nls, 'The code is 4 colored pegs, made from a choice of 6 different colors.'
    print nls, 'Repeated colors are allowed.'
    rules_div
  end

  def rules_step2
    print nls, 'Step 2:'
    print nls, 'The -Code Breaker- then guesses the secret code.'
    print nls, 'They get, by default, 12 guesses.'
    print nls, 'After each guess, feedback is provided on the right side of the board.'
    print nls, 'Second last column - Color & position is correct for a peg.'
    print nls, 'Last column - Color is correct, but the peg is in the wrong position.'
    rules_div
  end

  def rules_step3
    print nls, 'Step 3:'
    print nls, 'Have fun crushing your enemies...at Mastermind!'
    rules_div
  end

  def rules_step_end
    print nls, 'If further information is need, consult your local search engine.'
    print nls, 'Additionally, copy/follow this link to Wikipedia.'
    print nls, 'https://en.wikipedia.org/wiki/Mastermind_(board_game)'
    rules_div
    print nls, 'Happy Gaming', "\n"
  end
end
