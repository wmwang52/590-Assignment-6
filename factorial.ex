# Dylan Nicks, Coralee Rogers-Vickers, William Wang

defmodule Factorial do
  def main_loop do
    process_number()
    main_loop()
  end

  defp process_number do
    IO.write("Enter a number: ")
    input = String.trim(IO.gets(""))

    case parse_integer(input) do
      {:ok, n} -> handle_integer(n)
      :error -> IO.puts("Not an integer.")
    end
  end

  defp parse_integer(string) do
    case Integer.parse(string) do
      {int, ""} -> {:ok, int}
      _ -> :error
    end
  end

  defp handle_integer(n) when n < 0 do
    result = :math.pow(abs(n), 7)
    IO.puts("#{abs(n)} raised to the 7th power is: #{Float.round(result, 2)}")
  end

  defp handle_integer(0) do
    IO.puts("You entered 0. Ending program.")
    System.halt()
  end

  defp handle_integer(n) when n > 0 do
    if rem(n, 7) == 0 do
      root5 = :math.pow(n, 1 / 5)
      IO.puts("The 5th root of #{n} is: #{Float.round(root5, 2)}")
    else
      fact = factorial(n)
      IO.puts("The factorial of #{n} is: #{fact}")
    end
  end

  defp factorial(0), do: 1
  defp factorial(n) when n > 0, do: n * factorial(n - 1)
end

Factorial.main_loop()
