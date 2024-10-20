class Guessee

  def self.turn
    puts "make a 4-color code selection, separated by space\n\n"
    print "blue: 1, purple: 2, yellow: 3, red: 4, black: 5, white: 6 -- : "
    selection = gets.chomp
    Game.gets_compare(selection)
    Game.turn_counter
  end

end
