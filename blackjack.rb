puts "What is your name?"
name = gets.chomp
puts "Good luck #{name}!"

def calculate_total(cards)
  values = cards.map { |suit, value| value }
  total = 0
  values.each do |value|
    if value == "J" || value == "Q" || value == "K"
      total += 10
    elsif value == "A"
      total += 11
    else
      total += value.to_i
    end
  end
  values.select{ |value| value == "A"}.count.times do
    if total > 21
      total -= 10
    end
  end
  total
end

suits = ['Diamonds', 'Hearts', 'Spades', 'Clubs']
cards = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
deck = suits.product(cards)

begin 
  deck.shuffle!

  player_cards = []
  dealer_cards = []
  player_cards << deck.pop
  dealer_cards << deck.pop
  player_cards << deck.pop
  dealer_cards << deck.pop
  player_total = calculate_total(player_cards)
  dealer_total = calculate_total(dealer_cards)
  puts "Your cards are: #{player_cards}.  This adds to: #{player_total}."
  puts "The dealer has: #{dealer_cards}.  This adds to: #{dealer_total}."

  while player_total <= 21
    puts "What would you like to do?  Type H for hit or S for stay."
    move = gets.chomp.downcase
    if move == "h"
      player_cards << deck.pop
      player_total = calculate_total(player_cards)
      puts "Your cards are: #{player_cards}.  This adds to: #{player_total}."
      puts "The dealer has: #{dealer_cards}.  This adds to: #{dealer_total}."
    else
      break
    end
  end

  if player_total > 21
    puts "#{name} busts!  Dealer wins."
  else
    puts "The dealer has: #{dealer_cards}.  This adds to: #{dealer_total}."
    while dealer_total <= 16
      puts "The dealer needs to hit"
      dealer_cards << deck.pop
      dealer_total = calculate_total(dealer_cards)
      puts "The dealer now has: #{dealer_cards}.  This adds to: #{dealer_total}."
    end
    if dealer_total > 21
      puts "The dealer busts!  #{name} wins!"
    elsif player_total > dealer_total
      puts "#{name} wins!"
    elsif player_total < dealer_total
      puts "Dealer wins!"
    else
      puts "It is a tie!"
    end
  end
  puts "Would you like to play again?  Type Y for Yes, N for No."
  again = gets.chomp.downcase
end while again == "y"