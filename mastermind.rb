# frozen_string_literal: true

# https://stackoverflow.com/questions/1489183/how-can-i-use-ruby-to-colorize-the-text-output-to-a-terminal
# There is a colorize gem, but I didn't want to require others to install it.
# https://www.growingwiththeweb.com/2015/05/colours-in-gnome-terminal.html
# That's the color code for Gnome terminal. Is there difference for other OS?
# First: Foreground, dark (3) or light (9). Second: Color.
module Peg
  def empty_peg
    # 9 characters
    '_________'
  end

  def peg_array
    [red, green, yellow, blue, magenta, cyan]
  end

  def color(new_color, code)
    "\e[#{code}m#{new_color}\e[0m"
  end

  def red
    color('_Red_____', 31)
  end

  def green
    color('_Green___', 92)
  end

  def yellow
    color('_Yellow__', 93)
  end

  def blue
    color('_Blue____', 94)
  end

  def magenta
    color('_Magenta_', 95)
  end

  def cyan
    color('_Cyan____', 96)
  end
end

# 6 Colors to choose from.
# 4 slots to fill. 12 guesses total.
class GameBoard
  include Peg
  attr_writer :secret_code

  def initialize(guesses = 12, pegs = 4, content = empty_peg)
    @board = create_board(guesses, pegs, content)
    @guess = 0
    @final_guess = guesses
    @secret_code = []
  end

  def display
    print "\n"
    @secret_code.each { |word| print "|#{word}" }
    print '|'
    print "\n_________________________________________\n"
    @board.each do |row|
      row.each { |column| print "|#{column}" }
      # feedback in codemaker class? How should they interact?
      print "|\n"
    end
  end

  def place_guess(code)
    @board[@guess] = code
    @guess += 1
    @guess == @final_guess
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
  include Peg
  attr_reader :maker_code

  def initialize
    @maker_code = random_code
  end

  private

  def random_code
    # 'peg_array.sample(4)' works, except each element is unique.
    [peg_array.sample, peg_array.sample, peg_array.sample, peg_array.sample]
  end
end

# Guesses code out of 6 colors. 12 Geusses.
class CodeBreaker
  include Peg

  def new_guess(pegs = 4)
    # [peg_array.sample, peg_array.sample, peg_array.sample, peg_array.sample]
    guess_array = []
    pegs.times { guess_array.push(user_color) }
    guess_array
  end

  private

  def user_color
    print 'What color? '
    peg_array.each do |color|
      word = color.tr('_', '')
      initial = word.chars[5].downcase
      print "#{word}(#{initial}) "
    end
    print ': '
    user_input
  end

  def user_input
    gets
  end
end

# Make other classes protected? do it above initialize?
class Play
  def initialize
    @game_board = GameBoard.new
    @code_maker = CodeMaker.new
    @code_breaker = CodeBreaker.new
  end

  def game
    @game_board.secret_code = @code_maker.maker_code
    game_loop
  end

  private

  def game_loop
    @game_board.display
    loop do
      # gets
      break if @game_board.place_guess(@code_breaker.new_guess)

      @game_board.display
    end
    @game_board.display
  end
end

Play.new.game
