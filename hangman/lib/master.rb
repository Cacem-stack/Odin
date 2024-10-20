class Master

  def get_word(game)
    secret_word = ''
    puts "Your secret_word is:"
    secret_word = game.word_gen
    puts secret_word.join
  end
end

