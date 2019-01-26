defmodule Practice.Palindrome do
  def palindrome(word) do
    word_length = String.length(word)
    if word_length === 1 do
      true
    else
      chars = String.graphemes word
      first_half = Enum.take(chars, floor(word_length / 2))
      second_half = Enum.take(chars, (- floor(word_length / 2)))
      second_half = Enum.reverse(second_half)
      first_half == second_half
    end
  end
end
