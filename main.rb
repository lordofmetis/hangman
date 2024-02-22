# frozen_string_literal: true

require './game'
require './player'

def update_demonstration(game, guess)
  if game.demonstration.size != game.answer.size
    game.demonstration = game.answer.chars.map { |char| char == guess ? char : '_' }
  else
    game.answer.chars.each_with_index { |char, index| game.demonstration[index] = char if char == guess }
  end
end

print 'Do you want to load a saved game now?(y/n) '
response = gets.chomp.downcase
if response == 'y' && File.exist?('saved_game.yaml')
  game = Game.from_yaml(File.read('saved_game.yaml'))
  puts 'Welcome back.'
else
  game = Game.new(5, [], [], '')
  puts game
  game.starts
end

player = Player.new('Bob')

while game.count.positive?
  game.save?
  guess = player.input.strip
  game.count -= 1

  if game.answer.include? guess
    update_demonstration(game, guess)
    if game.won?
      puts 'You win!'
      break
    else
      puts "#{game.demonstration.join(' ')}. Remaining chances: #{game.count}."
    end
  else
    game.attempts << guess
    puts "Tried: #{game.attempts.join(', ')}. Remaining chances: #{game.count}."
  end
end

puts "The correct answer is \"#{game.answer}\"." if game.demonstration.join('') != game.answer
