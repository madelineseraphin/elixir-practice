defmodule Practice.Factor do 

  # Get the prime factorization of the given number
  # num: the number
  # odd_num: odd number used to check for odd prime factors
  # acc: the prime factors found so far
  def prime_factors(num, odd_num, acc) do
    cond do
      num === 2 ->
        acc = [2] ++ acc
	Enum.sort(acc)
      rem(num, 2) === 0 ->
        prime_factors(div(num, 2), odd_num, [2] ++ acc)
      odd_num <= :math.sqrt(num) ->
        if rem(num, odd_num) === 0 do
          prime_factors(div(num, odd_num), odd_num, [odd_num] ++ acc)
        else
          prime_factors(num, odd_num + 2, acc)
        end
      num > 2 ->
        acc = [num] ++ acc
	Enum.sort(acc)
    end
  end
      

  # Find all the prime factors of a number
  def factor(x) do
    if is_integer(x) do
      prime_factors(x, 3, [])
    else
      prime_factors(String.to_integer(x), 3, [])
    end
  end
end
