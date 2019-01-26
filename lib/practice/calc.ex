defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end


  # Determine the order of operations
  def order("*"), do: 2
  def order("/"), do: 2
  def order("+"), do: 1
  def order("-"), do: 1
  def order(_), do: 0


  # Get the postfix expression from an infix expression
  # infix: array of characters of an infix expression
  # result: the resulting postfix
  # ops: the working stack of operators in the expression
  def convert_to_postfix(infix, result, ops) do
    if infix === [] do
      result ++ ops
    else
      char = hd infix
      cond do
        order(char) < 1 ->
          convert_to_postfix((tl infix), result ++ [char], ops)
        ops === [] || order(char) > order(hd ops) ->
          convert_to_postfix((tl infix), result, [char] ++ ops)
        order(char) <= order(hd ops) ->
          chunked = Enum.chunk_by(ops, fn(op) ->
            order(op) >= order(char) end)
          result = result ++ (hd chunked)
          ops = [char] ++ (tl chunked)
          convert_to_postfix((tl infix), result, ops)
      end
    end
  end


  # Get the prefix expression from a postfix expression
  # postfix: array of characters of a postfix expression
  # ops: the working stack of operands in the expression
  def convert_to_prefix(postfix, ops) do
    if postfix === [] do
      hd ops
    else
      char = hd postfix
      if order(char) < 1 do
	convert_to_prefix((tl postfix), [char] ++ ops)
      else
	op1 = hd ops
	op2 = hd (tl ops)
        convert_to_prefix((tl postfix), [char <> " " <> op2 <> " " <> op1] ++ (tl (tl ops)))
      end
    end
  end
     

  # Determine the value of two operands using the given operator
  # opr: operator
  # op1: the first operand
  # op2: the second operand
  def evaluate_operation(opr, op1, op2) do
    case opr do
      "*" -> op1 * op2
      "/" -> op1 / op2
      "+" -> op1 + op2
      "-" -> op1 - op2
    end
  end
    
   
  # Determine the value of a prefix expression
  # prefix: array of characters of a prefix expression
  # ops: the working stack of operands in the expression
  def evaluate_prefix(prefix, ops) do
    if prefix === [] do
      hd ops
    else
      char = hd prefix
      if order(char) < 1 do
	char = elem(Float.parse(char), 0)
        evaluate_prefix((tl prefix), [char] ++ ops)
      else
        op1 = hd ops
        op2 = hd (tl ops)
        eval = evaluate_operation(char, op1, op2)
        evaluate_prefix((tl prefix), [eval] ++ (tl (tl ops)))
      end
    end
  end
 
 
  # Calculate with +,-,*,/ using order of operations   
  def calc(expr) do
    expr
    |> String.split(" ")
    |> convert_to_postfix([], [])
    |> convert_to_prefix([])
    |> String.split(" ")
    |> Enum.reverse
    |> evaluate_prefix([])
  end
end
