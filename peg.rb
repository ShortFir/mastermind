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
