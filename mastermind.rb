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

  def initialize(guess_total = 12, pegs = 4, content = empty_peg)
    @current_guess = 0
    @secret_code = []
    @guess_total = guess_total
    @pegs = pegs
    @content = content
    @board = create_board
  end

  def display
    # display_secret_code
    display_divider
    display_header
    display_divider
    display_board
    display_divider
    puts
  end

  def update_board(code)
    @board[@current_guess] = code
    @board[@current_guess].concat(position_color_match)
    @current_guess += 1
  end

  def last_guess?
    @current_guess == @guess_total
  end

  def winner?
    @board[@current_guess - 1][-2] == @pegs
  end

  private

  def create_board
    # Array format: ['____', '____', '____', '____', 0, 0]
    Array.new(@guess_total, Array.new(@pegs, @content).push(0, 0))
  end

  def display_secret_code
    puts
    @secret_code.each { |word| print "|#{word}" }
    print "|\n"
  end

  def display_divider
    print '-------------------------------------------------------------'
  end

  def display_header
    print "\n|  Peg 1  |  Peg 2  |  Peg 3  |  Peg 4  | Col&Pos |  Color  |\n"
  end

  def display_board
    puts
    @board.each do |row|
      row.each do |column|
        column.is_a?(Integer) ? (print "|    #{column}    ") : (print "|#{column}")
      end
      print "|\n"
    end
  end

  # def position_match
  #   amount = 0
  #   @board[@current_guess].each_with_index do |word, index|
  #     word == @secret_code[index] ? amount += 1 : false
  #   end
  #   amount
  # end

  # def color_match
  #   0
  # end

  def position_color_match
    secret = Array.new(@secret_code) # Otherwise it passes the reference?
    current = Array.new(@board[@current_guess])
    # pos = 0
    # col = 0
    # current.each_with_index do |word, index|
    #   if secret.any?(word)
    #     col += 1
    #     if secret[index] == word
    #       col -= 1
    #       pos += 1
    #       secret.delete_at(index)
    #       current.delete_at(index)
    #     end
    #   end
    # end
    # array1 = Array.new(match_remove(secret, current))
    # array2 = Array.new(match_any(array1[0], array1[1]))
    array1 = match_remove(secret, current)
    col = match_any(array1[0], array1[1])
    [array1[2], col]
  end

  def match_remove(array1, array2, amount = 0, index = 0)
    # amount, index = 0, 0
    # @pegs.times do
    until array1[index].nil?
      if array1[index] == array2[index]
        array1.delete_at(index)
        array2.delete_at(index)
        amount += 1
      else
        index += 1
      end
    end
    [array1, array2, amount]
  end

  def match_any(array1, array2, amount = 0, index = 0)
    # until array2[index].nil?
    array1.length.times do
      if array1.any?(array2[index])
        array2.delete_at(index)
        amount += 1
      else
        index += 1
      end
    end
    # [array1, array2, amount]
    amount
  end
end

# Stores 4 color code.
# 6 Colors to choose from.
# matches guesess against code.
# provide feedback on correct color and position, and correct color wrong pos
class CodeMaker
  include Peg
  attr_reader :maker_code

  def initialize(pegs = 4)
    @pegs = pegs
    @maker_code = random_code
  end

  private

  def random_code
    # 'peg_methods.sample(@pegs)' works, except each element is unique.
    # This way can get repeat colors.
    array = []
    @pegs.times { array.push(peg_methods.sample) }
    array
  end
end

# Maybe have these 2 methods have parent Player class?
# Guesses code out of 6 colors. 12 Guesses.
class CodeBreaker
  include Peg

  def initialize(pegs = 4, user = 'human')
    @pegs = pegs
    @user = user
  end

  def new_guess
    guess_array = []
    if @user == 'human'
      @pegs.times { |ind| guess_array.push(peg_methods[user_selection(ind)]) }
    else
      @pegs.times { guess_array.push(peg_methods.sample) }
    end
    guess_array
  end

  private

  def user_selection(ind)
    output_color_selection(ind)
    peg_index
  end

  def output_color_selection(ind)
    peg_methods.each_index do |index|
      print " #{peg_names[index]}(#{peg_initials[index]})"
    end
    print " - Peg #{ind + 1}:"
    # print ':'
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
    @game_board.display
    game_loop
  end

  private

  def game_loop
    loop do
      @game_board.update_board(@code_breaker.new_guess)
      @game_board.display
      break if @game_board.winner? || @game_board.last_guess?
    end
    if @game_board.winner?
      puts 'Code Breaker Wins!'
    else
      puts 'Code Maker Wins! (You Lose)'
    end
  end
end

Play.new.game
