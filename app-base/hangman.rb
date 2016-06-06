require "pry"
require 

require "minitest/autorun"
class Hangman
end


h = Hangman.new < Minitest::Test
  def test_is_not_over_at_start
    g = Hangman.new
    assert_equal false, g.over?
  end

until h.over?
  puts "whats your guess?"
  guess = gets.chomp

  h.record_guess guess
end

if h.won?
  puts "you win"
elseputs "you lost answer was #{.answer}"
end
