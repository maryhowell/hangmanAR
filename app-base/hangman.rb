require "./db/setup"
require "./lib/all"
require "pry"
word = [ ]
board = [ ]
guesses = 6
prevguess = [ ]
done = false
check = false

def get_user_name
  puts "Whats your name?"
  username = gets.chomp
  User.where(username: username).first_or_create!
  username
end

def randomword_generator
  db = File.open("/usr/share/dict/words").select { |x| (x.length > 3) && (x.length < 6)}
  return db
end

def chomp_word db
  db.sample.chomp.downcase.split("")
end

def board_init randomword
  board = ["_"] * randomword.length
end

def current_guess_to_guessed guess, guessed
  prevguess.push(input)
end

def record_compare_guess randomword, input, board
  i = 0
  randomword.each do |s|
    if s == input
      board[i] = input
    end
    i += 1
  end
  board
end

def update_guess_left board, input, guesses
  if board.include? input
    guesses
  else
    guesses -= 1
  end
  guesses
end

def play_again? username
  show_record username
  puts "Would you like to play again y or n?"
  again = gets.chomp
end

def check_input_for_a_letter input
  check = false
  until check
    if ("a" .. "z").include?(input)
      check = true
    elsif input.length > 1
      puts "please try another single letter"
      input = gets.chomp
    else puts "please try another single letter"
      input = gets.chomp
    end
  end
  input
end

def win_or_lose? board, randomword, guesses, username
  user_id = User.where(username: username).ids.first.to_s
  if board == randomword
    puts "YAY you have Won"
    win = Record.where(user_id: user_id).first_or_create!
    win.win +=1
    win.save!
    done = true
  elsif guesses == 0
    puts "You have Lost"
    puts "The word was #{randomword.join}"
    loss = Record.where(user_id: user_id).first_or_create!
    loss.loss +=1
    loss.save!
    done = true
  end
  done
end

def show_record username
  user = User.where(username: username).first_or_create!
  win = Record.where(user_id: user.id.to_s).first_or_create!.win
  loss = Record.where(user_id: user.id.to_s).first_or_create!.loss
  puts "You have killed #{loss} people, and saved #{win} people"
end


#Game starts here
loop do
  username = get_user_name
  system "clear"
  db = randomword_generator
  puts " Welcome to Hangman #{username}"
  randomword = chomp_word(db)
  # puts "your word is #{randomword}" #need to comment out when finished

  board = board_init randomword

  until done || guesses == 0
    puts "Hangman: " + board * " "
    puts "Letters Used: " + prevguess * " "
    puts "You have #{guesses} remaining guesses"
    puts "Choose a letter"
    input = gets.chomp

    check_input_for_a_letter(input)
    some_data = record_compare_guess(randomword, input, board)
    guesses = update_guess_left(board, input, guesses)
    done = win_or_lose?(board, randomword, guesses, username)
  end
  again = play_again? username

  break if again == "n"
  done = false
  guesses = 6
  prevguess = [ ]
end
# binding.pry
