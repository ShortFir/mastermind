# frozen_string_literal: true

# Inherited by Computer & Human class
class CodeBreaker
  include Peg
  attr_reader :user

  def initialize(pegs)
    @pegs = pegs
    @user = ''
  end

  def new_guess(feedback) end
end
