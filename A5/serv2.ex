# Dylan Nicks, Coralee Rogers-Vickers, William Wang

defmodule Serv2 do
  def start(next_pid) do
    spawn(__MODULE__, :loop, [next_pid])
  end

  def loop(next_pid) do
    receive do
      :update ->
        IO.puts("(serv2) Updating code.")
        Code.compile_file("serv2.ex")
        Serv2.loop(next_pid)

      :halt ->
        send(next_pid, :halt)
        IO.puts("(serv2) Halting.")
        :ok

      msg when is_list(msg) ->
        case msg do
          [head | _] when is_integer(head) ->
            sum = Enum.filter(msg, &is_number/1) |> Enum.sum()
            IO.puts("(serv2) Sum of numbers: #{sum}")
            Serv2.loop(next_pid)

          [head | _] when is_float(head) ->
            product = Enum.filter(msg, &is_number/1) |> Enum.reduce(1, &(&1 * &2))
            IO.puts("(serv2) Product of numbers: #{product}")
            Serv2.loop(next_pid)

          _ ->
            send(next_pid, msg)
            Serv2.loop(next_pid)
        end

      msg ->
        send(next_pid, msg)
        Serv2.loop(next_pid)
    end
  end
end
