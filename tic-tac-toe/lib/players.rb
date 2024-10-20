class Player
  def initialize(symbol, name)
    @symbol = symbol
    @name = name
  end

  def turn
    Board.selection(@name)
    Board.cell_change(@symbol)
  end
end
