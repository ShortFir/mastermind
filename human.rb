# frozen_string_literal: true

# Human Solving class
class Human < CodeBreaker
  include HumanInput
  def initialize(pegs)
    super
    @user = 'human'
  end

  def new_guess(_feedback)
    guess_array = []
    @pegs.times { |idx| guess_array.push(peg_methods[user_selection(idx)]) }
    guess_array
  end
end
