module CheckLibrary

  def menu
    Display.clear
    puts Display.menu
    question = "press the number corresponding to the actions in the menu : "
    condition = Proc.new{|input| return menu_choice(input.to_i) if [1,2].include?(input.to_i)}
    check_input(question, condition)
  end

  def menu_choice(choice)
    case choice
    when 1
      start
    when 2
      load_game
      start
    when 3
      save_game(current_data)
      start
    when 4
      new_game
    end
  end



#-----------------------------------------------

def load_save_file(saved_files, input)
  data = YAML.load(File.read("saved-games/#{saved_files[input]}"))
  @wrong_answers = data[:wrong_answers]
  @word_to_guess = data[:word_to_guess]
  @guess = data[:guess]
end

def load_game
  Display.clear
  saved_files = Dir.children('saved-games')
  puts print_files(saved_files)

  question = "Enter the number of the file you would like to load : "
  condition = Proc.new { |input| return load_save_file(saved_files, input.to_i) if (0...saved_files.length).include?(input.to_i) }
  check_input(question, condition)
end

def print_files(saved_files)
  string = ""
  saved_files.each_with_index do |file_name, index|
    string += "    [#{index}] #{file_name}\n"
  end
  string
end



#-----------------------------------------------


  def current_data
    data = {
      wrong_answers: @wrong_answers,
      word_to_guess: @word_to_guess,
      guess: @guess
    }
    YAML.dump(data)
  end

  def save_game(data)
    print "\nName your game : "
    fname = gets.chomp.downcase.strip + '.yaml'
    Dir.mkdir('saved-games') unless Dir.exist?('saved-games')
    File.open("saved-games/#{fname}", "w") { |file| file.write(data)}
    puts "Your game has been saved correctly".green.bold
    sleep(2)
  end

  def check_input(question, condition)
    try_again = "Wrong input!!! Maybe you already did that choice... try again...".red.bold
    cursor_up = lambda do
      $stdout.write "\n" 
      $stdout.write "\e[1A" 
      $stdout.write "\e[#{question.length}C"
    end

    $stdout.print question
    loop do
      input = STDIN.getch

      cursor_up.call
      print " " * input.length
      
      condition.call(input)
      
      cursor_up.call
      print try_again
      sleep(0.8)
      cursor_up.call
      print "#{" " * try_again.length}"
      cursor_up.call
    end
  end
end