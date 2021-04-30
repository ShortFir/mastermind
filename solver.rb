# frozen_string_literal: true

# Computer solving module, currently only works with 4 peg code.
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
