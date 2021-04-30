# frozen_string_literal: true

require_relative 'peg'
require_relative 'logos'
require_relative 'rules'
require_relative 'menuformat'
require_relative 'humaninput'
require_relative 'solver'
require_relative 'gameboard'
require_relative 'codemaker'
require_relative 'codebreaker'
require_relative 'human'
require_relative 'computer'
require_relative 'play'

Play.new.game
