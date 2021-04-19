# frozen_string_literal: true

# https://stackoverflow.com/questions/1489183/how-can-i-use-ruby-to-colorize-the-text-output-to-a-terminal
# There is a colorize gem, but I didn't want to require others to install it.
# https://www.growingwiththeweb.com/2015/05/colours-in-gnome-terminal.html
# That's the color code for Gnome terminal. Is there difference for other OS?
class String
  def color(code)
    # First: Foreground dark (3) or light (9). Second: Color.
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

# 6 Colors to choose from.
# 4 slots to fill. 12 guesses total.
class GameBoard
  def initialize(guesses = 12, pegs = 4, content = '_______')
    @board = create_board(guesses, pegs, content)
  end

  def display
    @board.each do |row|
      row.each { |column| print "|#{column}" }
      # feedback in codemaker class? How should they interact?
      print "|\n"
    end
  end

  private

  def create_board(guesses, pegs, content)
    Array.new(guesses, Array.new(pegs, content))
  end
end

# Stores 4 color code.
# 6 Colors to choose from.
# matches guesess against code.
# provide feedback on correct color and position, and correct color wrong pos
class CodeMaker
end

# Guesses code out of 6 colors. 12 Geusses.
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
    @game_board.display
  end
end

Play.new.game
