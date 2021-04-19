# frozen_string_literal: true

# https://stackoverflow.com/questions/1489183/how-can-i-use-ruby-to-colorize-the-text-output-to-a-terminal
# There is a colorize gem, but I didn't want to require others to install it.
# https://www.growingwiththeweb.com/2015/05/colours-in-gnome-terminal.html
# That's the color code for Gnome terminal. Is there difference for other OS?
class String
  def color(code)
    "\e[#{code}m#{self}\e[0m"
  end

  def red
    color(31)
  end

  def green
    color(92)
  end

  def yellow
    color(93)
  end

  def blue
    color(94)
  end

  def magenta
    color(95)
  end

  def cyan
    color(96)
  end
end

class GameBoard
end

class CodeMaker
end

class CodeBreaker
end

# Make other classes protected? do it above initialize?
class Play
  def initialize
    @game_board = GameBoard.new
    @code_maker = CodeMaker.new
    @code_breaker = CodeBreaker.new
  end

  def game
    puts 'Red'.red
    puts 'Green'.green
    puts 'Yellow'.yellow
    puts 'Blue'.blue
    puts 'Magenta'.magenta
    puts 'Cyan'.cyan
  end
end

Play.new.game
