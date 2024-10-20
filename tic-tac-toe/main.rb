require_relative 'lib/board.rb'
require_relative 'lib/game.rb'
require_relative 'lib/players.rb'

Game.start(Player.new("X","Player 1"), Player.new("O", "Player 2"))
