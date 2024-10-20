class Guessee
  @guess

  def make_guess()
    guess = ''
    puts "make a guess or save:"
    until guess.length == 1 || guess == 'save'
      print "Enter a single character: "
      guess = gets.chomp.downcase
      print "\n"
    end
    @guess = guess
  end

  def get_guess
    @guess
  end
end
