# Dylan Nicks, Coralee Rogers-Vickers, William Wang

defmodule Serv1 do
  def start(next_pid) do
    spawn(__MODULE__, :loop, [next_pid])
  end

  def loop(next_pid) do
    receive do
      :update ->
        IO.puts("(serv1) Updating code. testtest")
        Code.compile_file("serv1.ex")
        apply(__MODULE__, :loop, [next_pid])

      :halt ->
        send(next_pid, :halt)
        IO.puts("(serv1) Halting.")
        :ok

      {op, a, b} when is_atom(op) and is_number(a) and is_number(b) ->
        result =
          case op do
            :add -> a + b
            :sub -> a - b
            :mult -> a * b
            :div when b != 0 -> a / b
            :div -> IO.puts("(serv1) Error: division by zero") && nil
            _ -> send(next_pid, {op, a, b}) && nil
          end

        if result, do: IO.puts("(serv1) #{op} #{a}, #{b} = #{result}")
        Serv1.loop(next_pid)

      {op, a} when is_atom(op) and is_number(a) ->
        result =
          case op do
            :neg -> -a
            :sqrt when a >= 0 -> :math.sqrt(a)
            :sqrt -> IO.puts("(serv1) Error: sqrt of negative number") && nil
            _ -> send(next_pid, {op, a}) && nil
          end

        if result, do: IO.puts("(serv1) #{op} #{a} = #{result}")
        Serv1.loop(next_pid)

      msg ->
        send(next_pid, msg)
        Serv1.loop(next_pid)
    end
  end
end
