# frozen_string_literal: true

# This is a player class.
class Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def input
    puts 'Please make a guess.'
    gets.chomp.downcase
  end
end
