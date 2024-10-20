class Board

  @@current_player = ""
  @@choice = ""

  @@wincells = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]

  @@cells = Array(1..9)

  def self.current_player_get
    @@current_player
  end

  def self.selection(name)
    @@current_player = name
    puts "make a selection #{@@current_player}"
    print_board
    @@choice = gets.chomp.to_i()
    if @@choice >= 9
      until @@choice <= 9
      puts "Try again:"
      @@choice = gets.chomp.to_i
      end
    elsif @@choice <= 1
      until @@choice >= 1
        puts "Try again:"
        @@choice = gets.chomp.to_i
      end
    end
    @@choice = @@choice - 1
  end

  def self.cell_change(symbol)
    if Array(0..9).any?(@@cells[@@choice])
      @@cells[@@choice] = symbol
    else
      puts "bad choice"
      selection(@@current_player)
      cell_change(symbol)
    end
  end

  def self.print_board
    puts "#{@@cells[0]} | #{@@cells[1]} | #{@@cells[2]}"
    puts "#{@@cells[3]} | #{@@cells[4]} | #{@@cells[5]}"
    puts "#{@@cells[6]} | #{@@cells[7]} | #{@@cells[8]}"
  end

  def self.wcon?
    @@wincells.any? do |c|
      [@@cells[c[0]], @@cells[c[1]], @@cells[c[2]]].uniq.length == 1
    end
  end

  def self.tiecon?
    @@cells.all? { |element| element == "X" || element == "O"}
  end

end
