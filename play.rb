# frozen_string_literal: true

# Create this class to start program.
class Play
  include Logos
  include Rules
  include MenuFormat
  def game
    main_menu
    exit_game
  end

  private

  def main_menu
    loop do
      new_screen
      display_menu(['New Game', 'How To Play', 'Exit'])
      case await_input((1..3))
      when 1 then new_game_menu
      when 2 then display_rules
      when 3 then return
      end
    end
  end

  def new_game_menu(guess_total = 12, pegs = 4)
    loop do
      new_game2(guess_total, pegs)
      case await_input((1..4))
      when 1 then setup_game(guess_total, 4, 'computer'); break
      when 2 then setup_game(guess_total, pegs, 'human'); break
      when 3 then guess_total, pegs = rule_change
      when 4 then return
      end
    end
    game_loop_start
  end

  def new_game2(guess_total, pegs)
    new_screen
    print nls, "Current Rules: Guesses - #{guess_total} | Code Pegs - #{pegs}", "\n"
    display_menu(['Code Maker (Always 4 peg code)', 'Code Breaker', 'Change Rules', 'Main Menu'])
  end

  def setup_game(guess_total, pegs, user)
    new_screen
    @game_board = GameBoard.new(guess_total, pegs)
    @code_maker = CodeMaker.new(pegs, user)
    @game_board.secret_code = @code_maker.maker_code
    @code_breaker = user == 'human' ? Human.new(pegs) : Computer.new(pegs)
  end

  def rule_change(total = 0)
    new_screen
    print nls, 'How many guesses in total: (Even number from 2 - 20) (Default 12)? '
    loop do
      total = gets.chomp.to_i
      break if (2..20).include?(total) && (total % 2).zero?
    end
    print nls, 'How many pegs for secret code: (1 - 6) (Default 4)? '
    until (1..6).include?(peg = gets.chomp.to_i); end
    [total, peg]
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
      @game_board.update_board(@code_breaker.new_guess(@game_board.feedback))
      new_screen
      @game_board.display
      break if @game_board.breaker_wins? || @game_board.last_guess?

      pause_game if @code_breaker.user == 'computer'
    end
  end

  def await_input(range)
    until range.include?(select = gets.chomp.to_i); end
    select
  end

  def new_screen
    print "\e[H\e[2J" # Moves down to new screen
    print mastermind_logo_alt
  end

  def display_menu(menu_array = [])
    menu_array.each_with_index do |value, idx|
      print nls, "(#{idx + 1}) #{value}"
    end
    print nls, '> '
  end
end
