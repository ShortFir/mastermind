# frozen_string_literal: true

# Rubocop
module MenuFormat
  private

  def nls
    # newline, spaces
    "\n  "
  end

  def pause_game
    print nls, 'Press Enter To Continue...'
    gets
    puts
  end

  def win
    print nls, 'Code Breaker Wins!', "\n"
  end

  def lose
    print nls, 'Code Maker Wins!', "\n"
  end

  def exit_game
    print "\e[H\e[2J", nls, 'Good Bye!', "\n", "\n"
  end
end
