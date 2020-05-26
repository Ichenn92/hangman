require_relative 'module'

class Game
  include CheckLibrary

  def initialize
    @wrong_answers = 0
    @max_wrong_answers = 6
    @word_to_guess = select_random
    @guess = []
    menu
  end

  def start
    loop do
      Display.clear
      Display.round(@word_to_guess, @wrong_answers, @guess)
      @guess.push try_to_guess
      @wrong_answers += 1 unless @word_to_guess.include? @guess.last
      break if @wrong_answers == @max_wrong_answers || win?
    end
    final_screen(win?)
  end

  def select_random
    words = File.readlines('5desk.txt', chomp: true)
    words.shuffle.detect{ |word| word.length.between?(5,12) }
  end

  def try_to_guess
    question = "Make YOUR guess (or number for options) : "
    condition = Proc.new do |input|
      menu_choice(input.to_i) if [3,4].include?(input.to_i)
      return input unless (@guess.include?(input) || /[^a-z]/.match?(input)) || input === ""
    end
    check_input(question, condition)
  end

  def win?
    true if @word_to_guess.split("").all? { |letter| @guess.include?(letter) }
  end

  def final_screen(is_win = false)
    Display.clear
    Display.round(@word_to_guess, @wrong_answers, @guess)
    puts "\nThe correct word was #{@word_to_guess}\n"
    puts is_win ? Display.win : Display.lose
    menu_come_back
  end

  def menu_come_back
    print "press enter to open menu"                                                                                                    
    STDIN.getch   
    menu
  end
end