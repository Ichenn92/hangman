require 'bundler/inline'

gemfile true do
 source 'http://rubygems.org'
 gem 'colorize'
 gem 'io-console'
end

require 'yaml'
require 'colorize' # for repl.it add the gem
require 'io/console'
require_relative 'lib/display.rb'
require_relative 'lib/game.rb'

def new_game
  hangman = Game.new()
end

new_game