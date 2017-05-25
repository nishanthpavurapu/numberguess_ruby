require 'sinatra'
require 'sinatra/reloader'

$number = rand(100)

class NumberGuess
@@guess_count = 5

def initialize
@@guess_count -= 1
end

	def check_guess(guess,cheat)
	if @@guess_count < 0
			@@guess_count = 5
			$bgcolor = "white"
			return "You have lost! Restart the guess game"
else
			if guess > $number
				$bgcolor = "red"
				return ((guess - $number) > 5)? "Your guess is too high! " :  "Your guess is high! "  
			elsif guess < $number
				$bgcolor = "red"
				return  (($number -guess) > 5)?  "Your guess is too low! " : "Your guess is low! "
			else
				$bgcolor = "green"
				@@guess_count = 5
				$number = rand(100)
				return "Your guess is  Perfect!, The secret number is #{$number}"
			end
		end
		end
end

get '/' do
guess = params["guess"]
cheat = params["cheat"]
game = NumberGuess.new

	if guess.to_i != 0
		message = game.check_guess(guess.to_i,cheat)
		if cheat == "yes"
			message << "Cheat activated! Secret number is #{$number}"
		end
	else
		$bgcolor = "#FDFEFE"
	end
erb :index, :locals => {:message => message, :bgcolor => $bgcolor}
end