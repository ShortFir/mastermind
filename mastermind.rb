# frozen_string_literal: true

# https://stackoverflow.com/questions/1489183/how-can-i-use-ruby-to-colorize-the-text-output-to-a-terminal
# There is a colorize gem, but I didn't want to require others to install it.
# https://www.growingwiththeweb.com/2015/05/colours-in-gnome-terminal.html
# That's the color code for Gnome terminal. Is there difference for other OS?
module Peg
  def empty_peg
    # 9 characters, for display purposes.
    '_________'
  end

  def peg_methods
    # Modify this with new colors etc. Everything flows from here.
    # Obviously add the corresponding method aswell.
    [red, green, yellow, blue, magenta, cyan]
  end

  def peg_names
    # Keeps the color coding.
    array = []
    peg_methods.each { |method| array.push(method.tr('_', '')) }
    array
  end

  def peg_initials
    # Removes color coding. Since it needs to match user input. 'r' == 'r' etc.
    array = []
    peg_methods.each { |method| array.push(method.chars[6].downcase) }
    array
  end

  def color(new_color, code)
    # First: Foreground, regular (3) or light (9). Second: Color.
    # Background, regular (4), light (10).
    # Add additional codes by seperating with ; - 31;40 etc
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
    [
      peg_methods.sample, peg_methods.sample,
      peg_methods.sample, peg_methods.sample
    ]
  end
end

# Guesses code out of 6 colors. 12 Geusses.
class CodeBreaker
  include Peg

  def new_guess(pegs = 4, user = 'human')
    guess_array = []
    if user == 'human'
      pegs.times { guess_array.push(peg_methods[user_selection]) }
    else
      pegs.times { guess_array.push(peg_methods.sample) }
    end
    guess_array
  end

  private

  def user_selection
    output_color_selection
    peg_index
  end

  def output_color_selection
    print 'What color?'
    peg_methods.each_index do |index|
      print " #{peg_names[index]}(#{peg_initials[index]})"
    end
    print ':'
  end

  def peg_index
    until peg_initials.any?(selection = gets.chomp); end
    peg_initials.index(selection)
  end
end

# Create this class to start program.
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
      break if @game_board.place_guess(@code_breaker.new_guess)

      @game_board.display
    end
    @game_board.display
  end
end

Play.new.game
