class Game
  @@current_player = ""

  def self.start(player1, player2)
    loop do
      player1.turn
      break if Board.wcon? || Board.tiecon?
      player2.turn
      break if Board.wcon? || Board.tiecon?
    end
    if Board.wcon?
      puts Board.current_player_get + " won"
    elsif Board.tiecon?
      puts "Tie"
    end
    Board.print_board
  end
end
