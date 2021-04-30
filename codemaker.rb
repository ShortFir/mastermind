# frozen_string_literal: true

# For creating the code, either computer or human
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
