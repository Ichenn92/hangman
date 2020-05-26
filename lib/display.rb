class Display
  def self.clear
    print `clear`
  end

  def self.menu
    <<~HEREDOC

    888    888                                                           
    888    888                                                           
    888    888                                                           
    8888888888  8888b.  88888b.   .d88b.  88888b.d88b.   8888b.  88888b. 
    888    888     "88b 888 "88b d88P"88b 888 "888 "88b     "88b 888 "88b
    888    888 .d888888 888  888 888  888 888  888  888 .d888888 888  888
    888    888 888  888 888  888 Y88b 888 888  888  888 888  888 888  888
    888    888 "Y888888 888  888  "Y88888 888  888  888 "Y888888 888  888
                                      888                                
                                 Y8b d88P                                
                                  "Y88P"                                 

    WELCOME TO HANGMAN !!!
    please make your choice

    [1] to start a new game
    [2] to load a game


    HEREDOC
  end

  def self.round(word_to_guess, wrong_answers, guess)
    puts Display.show_hangman(wrong_answers)
    puts Display.hide_word(word_to_guess, guess)
    puts Display.show_letter_choice(guess)
    puts Display.parameter_ingame
  end

  def self.hide_word(word_to_guess, guess)
    hide_word = word_to_guess.gsub(/./){|letter| guess.include?(letter) ? letter : letter = '*'}
    hide_word.split("").join(" ".yellow)
  end

  def self.show_letter_choice(guess)
    "\nhere are the letter you already tried #{guess}"
  end

  def self.parameter_ingame
    <<~HEREDOC

    [3] to save the current game
    [4] to start a new game

    HEREDOC
  end

  def self.show_hangman(wrong_answers)
    case wrong_answers
    when 0
      <<~HEREDOC
      ══╤═════╦═
              ║
              ║
              ║
              ║
      ══════════

      HEREDOC
    when 1
      <<~HEREDOC
      ══╤═════╦═
        0     ║
              ║
              ║
              ║
      ══════════
    
      HEREDOC
    when 2
      <<~HEREDOC
      ══╤═════╦═
        0     ║
        |     ║
              ║
              ║
      ══════════

      HEREDOC
    when 3
      <<~HEREDOC
      ══╤═════╦═
        0     ║
       /|     ║
              ║
              ║
      ══════════

      HEREDOC
    when 4
      <<~HEREDOC
      ══╤═════╦═
        0     ║
       /|\\\    ║
              ║
              ║
      ══════════

      HEREDOC
    when 5
      <<~HEREDOC
      ══╤═════╦═
        0     ║
       /|\\\    ║
       /      ║
              ║
      ══════════

      HEREDOC
    when 6
      <<~HEREDOC
      ══╤═════╦═
        0     ║
       /|\\\    ║
       / \\\    ║
              ║
      ══════════

      HEREDOC
    end
  end

  def self.win
    <<~HEREDOC
                                                                   888
                                                                   888
                                                                   888
    888  888  .d88b.  888  888   888  888  888  .d88b.  88888b.    888
    888  888 d88""88b 888  888   888  888  888 d88""88b 888 "88b   888
    888  888 888  888 888  888   888  888  888 888  888 888  888   Y8P
    Y88b 888 Y88..88P Y88b 888   Y88b 888 d88P Y88..88P 888  888    " 
     "Y88888  "Y88P"  "Y88888     "Y8888888P"   "Y88P"  888  888   888
         888                                                      
    Y8b d88P                                                      
    "Y88P"      
    
    
    HEREDOC
  end
  
  def self.lose
    <<~HEREDOC
  
    ,-.    .---.    .---. ,---.  ,---.     .-. 
    | |   / .-. )  ( .-._)| .-'  | .-.\\\    |  )
    | |   | | |(_)(_) \\\   | `-.  | `-'/    | / 
    | |   | | | | _  \\\ \\\  | .-'  |   (     |/  
    | `--.\\\ `-' /( `-'  ) |  `--.| |\\\ \\\    (   
    |( __.')---'  `----'  /( __.'|_| \\\)\\\  (_)  
    (_)   (_)            (__)        (__)      


    HEREDOC
  end
end