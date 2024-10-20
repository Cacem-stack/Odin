class Game

  @@guess = ""
  @@codepool = ['blue', 'purple', 'yellow', 'red', 'black', 'white']
  @@code = @@codepool.shuffle[0..3]
  @@turn_counter = 0
  @@correct = 0
  @@misplaced = 0

  def self.correct
    if @@guess[0] == @@code[0]
      @@correct = @@correct + 1
    end
    if @@guess[1] == @@code[1]
      @@correct = @@correct + 1
    end
    if @@guess[2] == @@code[2]
      @@correct = @@correct + 1
    end
    if @@guess[3] == @@code[3]
      @@correct = @@correct + 1
    end
    return @@correct
  end

  def self.turn_counter
    @@turn_counter = @@turn_counter + 1
    puts "#{@@turn_counter} out of 12 turns.\n"
  end

  def self.misplaced
    if @@guess[0] != @@code[0] && @@code.any?(@@guess[0])
      @@misplaced = @@misplaced + 1
    end
    if @@guess[1] != @@code[1] && @@code.any?(@@guess[1])
      @@misplaced = @@misplaced + 1
    end
    if @@guess[2] != @@code[2] && @@code.any?(@@guess[2])
      @@misplaced = @@misplaced + 1
    end
    if @@guess[3] != @@code[3] && @@code.any?(@@guess[3])
      @@misplaced = @@misplaced + 1
    end
    return @@misplaced
  end
  
  def self.codefetch
    @@code
  end

  def self.wingame?
    @@guess == @@code
  end

  def self.losegame?
    @@turn_counter >= 12
  end

  def self.guessgen(selection)
    @@index = selection.split(' ')
    @@guess = [
      @@codepool[@@index[0].to_i - 1],
      @@codepool[@@index[1].to_i - 1],
      @@codepool[@@index[2].to_i - 1],
      @@codepool[@@index[3].to_i - 1],
    ]
    puts "your guess is #{@@guess}\n"
  end

  def self.gets_compare(selection)
    self.guessgen(selection)
    self.correct
    self.misplaced
    puts "You have #{@@correct} correct and #{@@misplaced} misplaced.\n" 
    @@correct = 0
    @@misplaced = 0

  end

  def self.start
    Mastermind.turn
    until wingame? || losegame?
      Guessee.turn
    end
    puts "Guessee wins" if wingame?
    puts "Fuck you" if losegame?
  end
end
