class Game

  @@dictionary = File.read('dict.txt').split

  def initialize
    @secret_word = []
    @guess = []
    @correctarr = []
    @guess_counter = 8
    @continue_query = ""
  end

  def fetch_secret(master)
    @secret_word.length.times do
      @correctarr.push("_")
    end
  end

  def fetch_guess(guessee)
    @guess = guessee.get_guess
  end

  def match_guess()
    @secret_word.each_with_index do |s, i|
      if s == @guess
        @correctarr[i] = @guess if @correctarr[i] == "_"
      elsif @guess == "save"
        break
      else
        next
      end
    end
    if @guess == "save"
      puts "Game saved"
    elsif @secret_word.any?(@guess) == false
      puts "No dice."
      @guess_counter -= 1
    end
    return if @guess == "save"
    puts "Remaining characters: #{@correctarr}"
    puts "Guessess remiaining: #{@guess_counter}"
  end

  def wcon?
    @correctarr == @secret_word
  end

  def lcon?
    @guess_counter == 0
  end

  def word_gen
    @secret_word = []
    until @secret_word.length >= 5 && @secret_word.length <= 12
      @secret_word = @@dictionary.shuffle[0].split('')
    end
    @secret_word
  end

  def get_save
    @guess
  end

end
