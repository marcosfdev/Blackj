def calculate_total(cards) # [['H', '3'], ['S', 'Q']...]
	arr = cards.map{|e| e[1] }

  total = 0
  arr.each do |value|
    if value == "A"
    	total += 11
    elsif value.to_i == 0  #J, Q, K
  		total += 10
    else
    	total += value.to_i
    end
  end

  #correct for Aces when total is over 21
  arr.select{|e| e == "A"}.count.times do
  	total -= 10 if total > 21
  end

    total
end

#Start Game

puts "Welcome to my Blackjack Game!"

# Make two arrays, one for suits and one for cards, then combine them together to make the deck
suits = ['H', 'D', 'S', 'C']
cards = [ '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

deck = suits.product(cards)
deck.shuffle!

# Who are the players (number of players, and player names)
puts "Who is Player 1?"
player1_name = gets.chomp
puts "Hello #{player1_name}"

puts "Okay #{player1_name}, let's play!"

playerhand = Array.new
dealerhand = Array.new

# Deal cards
playerhand << deck.pop
dealerhand << deck.pop
playerhand << deck.pop
dealerhand << deck.pop

dealertotal = calculate_total(dealerhand)
playertotal = calculate_total(playerhand)

# Show Cards
puts "Dealer has: #{dealerhand[0]} and #{dealerhand[1]}, which totals #{dealertotal}"
puts "Player has: #{playerhand[0]} and #{playerhand[1]}, which totals #{playertotal}"
puts ""

#Players turn
if playertotal == 21
	puts "Congratulations, you hit blackjack.  You win!"
  exit
end

while playertotal < 21
  puts "What would you like to do? 1) Hit or 2) Stay"
  hit_or_stay = gets.chomp

  if !['1', '2'].include?(hit_or_stay)
  	puts "Error: you must enter 1 or 2"
  	next
  end

  if hit_or_stay == "2"
    puts "You chose to stay."
  	break
  end

#hit
new_card = deck.pop
puts "Dealing card to player: #{new_card}"
playerhand << new_card
playertotal = calculate_total(playerhand)
puts "Your total is now: #{playertotal}"

if playertotal == 21
	puts "Congratulations, you hit blackjack.  You win!"
	exit
elsif playertotal > 21
  puts "Sorry, you busted!"
  exit
 end
end

#Dealer's turn

if dealerhand == 21
	puts "Sorry, dealer hit blackjack.  You lose."
	exit
end

while dealertotal < 17
	#hit
	new_card = deck.pop
	puts "Dealing new card for dealer: #{new_card}"
	dealerhand << new_card
	dealertotal = calculate_total(dealerhand)
	puts "Dealer total is now: #{dealertotal}"

	if dealertotal == 21
		puts "Sorry, dealer hit blackjack.  You lose."
		exit
  elsif dealertotal >21
  	puts "Congratulations, dealer busted!  You win!"
  end
end

# Compare hands

puts "Dealer's cards:"
dealerhand.each do |card|
	 puts "=> #{card}"
end
puts ""

puts "Your cards"
playerhand.each do |card|
	puts "=> #{card}"
end
puts ""

if dealertotal > playertotal
	puts "Sorry, dealer wins."
 elsif dealertotal < playertotal
 	puts "Congratulations, you win!"
 else
 	puts "It's a push. Player and Dealer tie."
 end

 exit