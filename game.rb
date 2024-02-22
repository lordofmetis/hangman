# frozen_string_literal: true

require 'yaml'

# This is a game class.
class Game
  attr_accessor :count, :demonstration, :attempts, :answer

  def initialize(count=5, demonstration=[], attempts=[], answer='')
    @count = count
    @demonstration = demonstration
    @attempts = attempts
    @answer = answer
  end

  def to_s
    'Welcome to the hangman game.'
  end

  def starts
    words = []

    contents = File.readlines('google-10000-english-no-swears.txt')

    contents.each do |content|
      content = content.gsub(/\n/, '')
      words.push(content) if content.length >= 5 && content.length <= 12
    end

    self.answer = words.sample
  end

  def won?
    demonstration.join('') == answer
  end

  def to_yaml
    YAML.dump ({
      'count': @count,
      'demonstration': @demonstration,
      'attempts': @attempts,
      'answer': @answer
    })
  end

  def save?
    print 'Do you want to save the game now?(y/n) '
    response = gets.chomp.downcase
    File.open('saved_game.yaml', 'w') { |file| file.write(to_yaml) } if response == 'y'
  end

  def self.from_yaml(string)
    data = YAML.safe_load(string, permitted_classes: [Symbol])
    new(data[:count], data[:demonstration], data[:attempts], data[:answer])
  end
end
