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
  private

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

# It's the Rules module
module Rules
  private

  def display_rules
    new_screen
    print rules_full
    # rules_title
    # rules_step1
    # rules_step2
    # rules_step3
    # rules_step_end
    pause_game
  end

  def nls
    # newline, spaces
    "\n  "
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

# Rubocop
module MenuStuff
  private

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

# Attempts at computer solving.
module Solver
  private

  def create_set
    set = []
    (1111..6666).each { |value| set.push(value) }
    set = mod_set(set, /[0789]/, true)
  end

  def testing
    set = create_set
    solve(set, 1, [0, 0])
    p set
    until set.length == 1
      sample, set = sample_set(set)
      p sample, set
    end
  end

  def sample_set(set)
    sample = set.sample
    set.delete(sample)
    [sample, set]
  end

  def solve(set = [], num = 1, feedback = [0, 0])
    case feedback.reduce(:+)
    when 0 then set = mod_set(set, reg0(num), true)
    when 1
      set = mod_set(set, reg1(num), false)
      set = mod_set(set, reg2(num), true)
    when 2
      set = mod_set(set, reg2(num), false)
      set = mod_set(set, reg3(num), true)
    when 3
      set = mod_set(set, reg3(num), false)
      set = mod_set(set, reg4(num), true)
    end
    set
  end

  def mod_set(set, reg, delete)
    # deletes matches, or deletes non-matches
    if delete
      set.delete_if { |value| value.to_s =~ reg }
    else
      set.delete_if { |value| value.to_s !~ reg }
    end
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
  attr_writer :secret_code
  attr_reader :feedback

  def initialize(guess_total, pegs)
    @current_guess = 0
    @secret_code = []
    @guess_total = guess_total
    @pegs = pegs
    @content = empty_peg # From Peg Module
    @board = create_board
    @feedback = []
  end

  def display
    puts
    display_divider
    display_header
    display_divider
    display_board
    display_divider
    puts
  end

  def update_board(code)
    @board[@current_guess] = code
    @feedback = position_color_match
    @board[@current_guess].concat(@feedback)
    @current_guess += 1
  end

  def last_guess?
    @current_guess == @guess_total
  end

  def breaker_wins?
    @board[@current_guess - 1][-2] == @pegs
  end

  def display_secret_code
    print "\n    Secret: "
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

# Include this in the Code class's
module HumanInput
  def user_selection(idx)
    output_color_selection(idx)
    peg_index
  end

  def output_color_selection(peg_idx)
    print ' '
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

# Parent class for human input?
class CodeMaker
  include Peg
  include HumanInput
  attr_reader :maker_code

  def initialize(pegs, user)
    @pegs = pegs
    @maker_code = user == 'computer' ? user_code : random_code
  end

  private

  def user_code
    print "\n  ", '-Code Maker-, please enter color code.'
    print "\n  ", '4 colors total, repeat colors allowed.', "\n", "\n"
    array = []
    @pegs.times { |idx| array.push(peg_methods[user_selection(idx)]) }
    array
  end

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
  include HumanInput
  include Solver

  def initialize(pegs, user)
    @pegs = pegs
    @user = user
    return unless @user == 'computer'

    @set = create_set
    @guess_set = [1, 2, 3, 4, 5, 6]
    @sample = 0
    @total = 0
  end

  def new_guess(feedback = [])
    guess_array = []
    case @user
    when 'human'
      @pegs.times { |idx| guess_array.push(peg_methods[user_selection(idx)]) }
    when 'computer'
      guess_array = computer_solve(feedback)
      # @pegs.times { guess_array.push(peg_methods.sample) }
    end
    guess_array
  end

  private

  # Solving moved to module?
  def computer_solve(feedback, guess = [])
    @total += feedback.reduce(:+) if feedback != []
    @total >= @pegs ? comp_solve_max_pegs : comp_solve_else(feedback, guess)
  end

  def comp_solve_max_pegs
    until @guess_set == []
      sample_guess
      @set = solve(@set, @sample)
    end
    print "Solution Set: #{@set}"
    sample, @set = sample_set(@set)
    convert_guess(sample.to_s.split(''))
  end

  def comp_solve_else(feedback, guess)
    @set = solve(@set, @sample, feedback) if feedback != []
    sample_guess
    @pegs.times { guess.push(@sample) }
    convert_guess(guess)
  end

  def sample_guess
    @sample = @guess_set.sample
    @guess_set.delete(@sample)
  end

  def convert_guess(guess)
    array = []
    guess.each { |value| array.push(peg_methods[value.to_i - 1]) }
    array
  end
end

# Create this class to start program.
class Play
  include Logos
  include Rules
  include MenuStuff
  def game
    main_menu
  end

  private

  def main_menu(select = 99)
    until select == 3
      new_screen
      display_menu(['New Game', 'How To Play', 'Exit'])
      until (1..3).include?(select = gets.chomp.to_i); end
      case select
      when 1 then new_game
      when 2 then display_rules
      when 3 then exit_game
      end
    end
  end

  def new_game(guess_total = 12, pegs = 4, user = 'human', stay = true)
    while stay
      new_game2(guess_total, pegs)
      until (1..4).include?(select = gets.chomp.to_i); end
      case select
      when 1
        user = 'computer'
        pegs = 4
        stay = false
      when 2
        user = 'human'
        stay = false
      when 3 then guess_total, pegs = rule_change
      when 4 then return
      end
    end
    setup_game(guess_total, pegs, user)
    game_loop_start(user)
  end

  def new_game2(guess_total, pegs)
    new_screen
    # print nls, 'Do you want to make the code, break it, or go back?'
    print nls, "Current Rules: Guesses - #{guess_total} | Code Pegs - #{pegs}", "\n"
    display_menu(['Code Maker (Always 4 peg code)', 'Code Breaker', 'Change Rules', 'Main Menu'])
  end

  def rule_change(total = 0)
    new_screen
    print nls, 'How many guesses in total: (Even No. 2 - 20) (Default 12)? '
    loop do
      total = gets.chomp.to_i
      break if (2..20).include?(total) && (total % 2).zero?
    end
    print nls, 'How many pegs for secret code: (1 - 6) (Default 4)? '
    until (1..6).include?(peg = gets.chomp.to_i); end
    [total, peg]
  end

  def setup_game(guess_total, pegs, user)
    new_screen
    @game_board = GameBoard.new(guess_total, pegs)
    @code_maker = CodeMaker.new(pegs, user)
    @game_board.secret_code = @code_maker.maker_code
    @code_breaker = CodeBreaker.new(pegs, user)
  end

  def game_loop_start(user)
    new_screen
    @game_board.display
    game_loop(user)
    @game_board.display_secret_code
    @game_board.breaker_wins? ? win : lose
    pause_game
  end

  def game_loop(user)
    loop do
      @game_board.update_board(@code_breaker.new_guess(@game_board.feedback))
      new_screen
      # print @game_board.feedback
      @game_board.display
      break if @game_board.breaker_wins? || @game_board.last_guess?

      pause_game if user == 'computer'
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
      print nls, "(#{idx + 1}) #{value}"
    end
    print nls, '> '
  end
end

Play.new.game
