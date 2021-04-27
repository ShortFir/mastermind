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

# Bunch of big ass logos
module Logos
  def mastermind_logo_alt
    print "\n"
    print "\n", '  ███╗░░░███╗░█████╗░░██████╗████████╗███████╗██████╗░███╗░░░███╗██╗███╗░░██╗██████╗░'
    print "\n", '  ████╗░████║██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗████╗░████║██║████╗░██║██╔══██╗'
    print "\n", '  ██╔████╔██║███████║╚█████╗░░░░██║░░░█████╗░░██████╔╝██╔████╔██║██║██╔██╗██║██║░░██║'
    print "\n", '  ██║╚██╔╝██║██╔══██║░╚═══██╗░░░██║░░░██╔══╝░░██╔══██╗██║╚██╔╝██║██║██║╚████║██║░░██║'
    print "\n", '  ██║░╚═╝░██║██║░░██║██████╔╝░░░██║░░░███████╗██║░░██║██║░╚═╝░██║██║██║░╚███║██████╔╝'
    print "\n", '  ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═════╝░░░░╚═╝░░░╚══════╝╚═╝░░╚═╝╚═╝░░░░░╚═╝╚═╝╚═╝░░╚══╝╚═════╝░'
    print "\n"
  end

  def mastermind_logo_epic
    print "\n"
    print "\n", '   _______  _______  _______ _________ _______  _______  _______ _________ _        ______  '
    print "\n", '  (       )(  ___  )(  ____ \\__   __/(  ____ \(  ____ )(       )\__   __/( (    /|(  __  \ '
    print "\n", '  | () () || (   ) || (    \/   ) (   | (    \/| (    )|| () () |   ) (   |  \  ( || (  \  )'
    print "\n", '  | || || || (___) || (_____    | |   | (__    | (____)|| || || |   | |   |   \ | || |   ) |'
    print "\n", '  | |(_)| ||  ___  |(_____  )   | |   |  __)   |     __)| |(_)| |   | |   | (\ \) || |   | |'
    print "\n", '  | |   | || (   ) |      ) |   | |   | (      | (\ (   | |   | |   | |   | | \   || |   ) |'
    print "\n", '  | )   ( || )   ( |/\____) |   | |   | (____/\| ) \ \__| )   ( |___) (___| )  \  || (__/  )'
    print "\n", '  |/     \||/     \|\_______)   )_(   (_______/|/   \__/|/     \|\_______/|/    )_)(______/ '
    print "\n"
  end

  def mastermind_logo_big
    print "\n"
    print "\n", '   __  __           _____ _______ ______ _____  __  __ _____ _   _ _____  '
    print "\n", '  |  \/  |   /\    / ____|__   __|  ____|  __ \|  \/  |_   _| \ | |  __ \ '
    print "\n", '  | \  / |  /  \  | (___    | |  | |__  | |__) | \  / | | | |  \| | |  | |'
    print "\n", '  | |\/| | / /\ \  \___ \   | |  |  __| |  _  /| |\/| | | | | . ` | |  | |'
    print "\n", '  | |  | |/ ____ \ ____) |  | |  | |____| | \ \| |  | |_| |_| |\  | |__| |'
    print "\n", '  |_|  |_/_/    \_\_____/   |_|  |______|_|  \_\_|  |_|_____|_| \_|_____/ '
    print "\n"
  end
end

# Attempts at computer solving.
module Solver
  def create_set
    set = []
    @solutions = []
    (1111..6666).each { |value| set.push(value) }
    set = mod_set(set, /[0789]/)
    set = mod_set(set, reg0(1))
    set = mod_set(set, reg0(2))
    set = mod_set(set, reg0(3))
    set = mod_set(set, reg3(4), false)
    set = mod_set(set, reg4(4))
    set = mod_set(set, reg1(5), false)
    set = mod_set(set, reg2(5))
    # puts `clear`
    # puts "\e[H\e[2J"
    p "Solutions: #{@solutions}"
    p "Set:  #{set}"
  end

  def mod_set(set, reg, delete = true)
    if delete
      set.delete_if { |value| value.to_s =~ reg }
    else
      set.delete_if { |value| value.to_s !~ reg }
    end
    @solutions.push(set.length)
    set
  end

  def reg0(num)
    /#{num}/
  end

  def reg1(num)
    /#{num}\d\d\d|\d#{num}\d\d|\d\d#{num}\d|\d\d\d#{num}/
  end

  def reg2(num)
    # %r{
    #   /#{num}#{num}\d\d|
    #   #{num}\d\d#{num}|
    #   \d\d#{num}#{num}|
    #   \d#{num}#{num}\d|
    #   \d#{num}\d#{num}|
    #   #{num}\d#{num}\d/
    # }x
    /#{num}#{num}\d\d|\d\d#{num}#{num}|#{num}\d\d#{num}|\d#{num}#{num}\d|\d#{num}\d#{num}|#{num}\d#{num}\d/
  end

  def reg3(num)
    # %r{
    #   /#{num}#{num}#{num}\d|
    #   #{num}#{num}\d#{num}|
    #   #{num}\d#{num}#{num}|
    #   \d#{num}#{num}#{num}/
    # }x
    /#{num}#{num}#{num}\d|#{num}#{num}\d#{num}|#{num}\d#{num}#{num}|\d#{num}#{num}#{num}/
  end

  def reg4(num)
    /#{num}#{num}#{num}#{num}/
  end
end

# 6 Colors to choose from.
class GameBoard
  include Peg
  # include Solver
  attr_writer :secret_code

  def initialize(guess_total, pegs)
    @current_guess = 0
    @secret_code = []
    @guess_total = guess_total
    @pegs = pegs
    @content = empty_peg # From Peg Module
    @board = create_board
  end

  def display
    # print "\n", display_divider, "\n"
    puts
    display_divider
    puts
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

  def breaker_wins?
    @board[@current_guess - 1][-2] == @pegs
  end

  def display_secret_code
    print "\n  Secret: "
    @secret_code.each { |word| print "|#{word}" }
    print "|\n"
  end

  private

  def create_board
    # Array format: ['____', '____', '____', '____', 0, 0]
    Array.new(@guess_total, Array.new(@pegs, @content).push(0, 0))
  end

  def display_divider
    print '  -----------' # 11 + 2 space
    @board[0].length.times { print '----------' } # 10
  end

  def display_header
    print "\n  |  Guess  "
    (@board[0].length - 2).times { |idx| print "|  Peg #{idx + 1}  " }
    print "| Col&Pos |  Color  |\n"
  end

  def display_board
    puts
    @board.each_with_index do |row, idx|
      temp_i = idx < 9 ? " #{idx + 1}" : (idx + 1).to_s
      print "  |   #{temp_i}    "
      row.each do |column|
        column.is_a?(Integer) ? (print "|    #{column}    ") : (print "|#{column}")
      end
      print "|\n"
    end
  end

  def position_color_match
    secret = Array.new(@secret_code) # Otherwise it passes the reference???
    current = Array.new(@board[@current_guess])
    first_pass = match_remove(secret, current)
    col = match_any(first_pass[0], first_pass[1])
    [first_pass[2], col]
  end

  def match_remove(secret1, guess1, amount = 0, idx = 0)
    until secret1[idx].nil?
      if secret1[idx] == guess1[idx]
        secret1.delete_at(idx)
        guess1.delete_at(idx)
        amount += 1
      else
        idx += 1
      end
    end
    [secret1, guess1, amount]
  end

  def match_any(secret2, guess2, amount = 0, idx = 0)
    until guess2[idx].nil?
      if secret2.any?(guess2[idx])
        secret2.delete_at(secret2.index(guess2[idx]))
        guess2.delete_at(idx)
        amount += 1
      else
        idx += 1
      end
    end
    amount
  end
end

# Parent class for human input?
class CodeMaker
  include Peg
  attr_reader :maker_code

  def initialize(pegs)
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
class CodeBreaker
  include Peg

  def initialize(pegs, user)
    @pegs = pegs
    @user = user
  end

  def new_guess
    guess_array = []
    if @user == 'breaker'
      @pegs.times { |ind| guess_array.push(peg_methods[user_selection(ind)]) }
    else
      # calls solver
      @pegs.times { guess_array.push(peg_methods.sample) }
    end
    guess_array
  end

  private

  def user_selection(idx)
    output_color_selection(idx)
    peg_index
  end

  def output_color_selection(peg_idx)
    print '   '
    peg_methods.each_index do |idx|
      print " #{peg_names[idx]}(#{peg_initials[idx]})"
    end
    print " - Peg #{peg_idx + 1}> "
  end

  def peg_index
    until peg_initials.any?(selection = gets.chomp); end
    peg_initials.index(selection)
  end
end

# Create this class to start program.
class Play
  include Logos
  include Solver
  def game
    # create_set
    main_menu
  end

  private

  def main_menu(select = 99)
    until select == 3
      new_screen
      display_menu(['New Game', 'Rules', 'Exit'])
      until (1..3).include?(select = gets.chomp.to_i); end
      case select
      when 1 then new_game
      when 2 then display_rules
      when 3 then exit_game
      end
    end
  end

  def new_game(user = '')
    new_screen
    new_game2
    until (1..3).include?(select = gets.chomp.to_i); end
    case select
    when 1 then user = 'maker'
    when 2 then user = 'breaker'
    when 3 then return
    end
    setup_game(12, 4, user)
    game_loop_start
  end

  def new_game2
    print "\n", '  Do you want to make the code, break it, or go back?'
    display_menu(['Code Maker', 'Code Breaker', 'Main Menu'])
  end

  def setup_game(guess_total = 12, pegs = 4, breaker_user = 'breaker')
    @game_board = GameBoard.new(guess_total, pegs)
    @code_maker = CodeMaker.new(pegs)
    @code_breaker = CodeBreaker.new(pegs, breaker_user)
    @game_board.secret_code = @code_maker.maker_code
  end

  def game_loop_start
    new_screen
    @game_board.display
    game_loop
    @game_board.display_secret_code
    @game_board.breaker_wins? ? win : lose
    pause_game
  end

  def game_loop
    loop do
      @game_board.update_board(@code_breaker.new_guess)
      new_screen
      @game_board.display
      break if @game_board.breaker_wins? || @game_board.last_guess?
    end
  end

  def new_screen
    print "\e[H\e[2J" # Moves down to new screen
    # mastermind_logo_big
    # mastermind_logo_epic
    mastermind_logo_alt
  end

  def display_menu(menu_array = [])
    menu_array.each_with_index do |value, idx|
      print "\n", "  (#{idx + 1}) #{value}"
    end
    print "\n", '  > '
  end

  def pause_game
    print "\n", '  Press Enter To Continue...'
    gets
    puts
  end

  def win
    print "\n", '  Code Breaker Wins!', "\n"
  end

  def lose
    print "\n", '  Code Maker Wins!', "\n"
  end

  def exit_game
    print "\e[H\e[2J", "\n", '  Good Bye!', "\n", "\n"
  end

  def display_rules
    new_screen
    print "\n", '  Rules', "\n"
    pause_game
  end
end

Play.new.game
