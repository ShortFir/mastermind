# frozen_string_literal: true

# For solving the code, either computer or human
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
