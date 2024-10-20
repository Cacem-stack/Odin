require_relative "lib/game.rb"
require_relative "lib/guessee.rb"
require_relative "lib/master.rb"
require "pry-byebug"
require "yaml"

continue_query = ""

master = Master.new
guessee = Guessee.new
game = Game.new

def save_query(continue_query, master, guessee, game)
  puts "Continue? y/n:"
  until continue_query == "y" || continue_query == "n"
    continue_query = gets.chomp.downcase
  end
  if continue_query == "y"
    serialized = File.read('save.rb')
    game = Marshal::load(serialized)
    start(master, guessee, game)
  elsif continue_query == "n"
    master.get_word(game)
    game.fetch_secret(master)
    start(master, guessee, game)
  end
end

def start(master, guessee, game)
  until game.wcon? || game.lcon?
    guessee.make_guess
    game.fetch_guess(guessee)
    game.match_guess
    if game.get_save == "save"
    serialized = Marshal::dump(game)
      File.open('save.rb', 'w') do |file|
        file.write serialized
      end
      break
    end
  end
  if game.wcon?
    puts "You win"
  elsif game.lcon?
    puts "You lose"
  end

end

save_query(continue_query, master, guessee, game)
