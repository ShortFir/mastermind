# frozen_string_literal: true

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
