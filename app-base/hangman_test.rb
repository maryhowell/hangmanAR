require "minitest/autorun"
require "./hangman"

 class HangmanTest < Minitest::Test
  def test_is_not_over_at_start
    g = Hangman.new
    binding.pry
    assert_equal false, g.over?
  end
end
