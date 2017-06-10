require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(0..100)

get '/' do
  guess = params["guess"] || "x"
  message = check_guess(guess)
  erb :index, :locals => {
                          :number => SECRET_NUMBER,
                          :message => message,
                          :color => determine_color(guess)
                          }
end

# params["guess"]
def check_guess(guess)
  if guess == "x"
    "Make a guess!"
  elsif guess.to_i == SECRET_NUMBER
    "You got it right\n The SECRET NUMBER is #{SECRET_NUMBER}"
  elsif guess.to_i > SECRET_NUMBER
    high_message(guess)
  elsif guess.to_i < SECRET_NUMBER
    low_message(guess)
  end
end

def determine_color(guess)
  if guess == "x"
    "#ffffff"
  elsif guess.to_i == SECRET_NUMBER
   "#00cc66"
 elsif (guess.to_i > (SECRET_NUMBER + 5)) || (guess.to_i < (SECRET_NUMBER - 5))
   "#ff3333"
 elsif (guess.to_i > SECRET_NUMBER) || (guess.to_i < SECRET_NUMBER)
   "#ffcccc"
 end
end

def high_message(guess)
  if guess.to_i > (SECRET_NUMBER + 5)
    "Way too high!"
  else
    "Too high!"
  end
end

def low_message(guess)
  if guess.to_i < (SECRET_NUMBER - 5)
    "Way too low!"
  else
    "Too low"
  end
end
