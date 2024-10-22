# Dylan Nicks, Coralee Rogers-Vickers, William Wangmy

defmodule Serv3 do
  def start do
    spawn(__MODULE__, :loop, [0])
  end

  def loop(acc) do
    receive do
      :update ->
        IO.puts("(serv3) Updating code.")
        Code.compile_file("serv3.ex")
        Serv3.loop(acc)

      :halt ->
        IO.puts("(serv3) Halting. Unprocessed messages count: #{acc}")
        :ok

      {:error, msg} ->
        IO.puts("(serv3) Error: #{inspect(msg)}")
        Serv3.loop(acc)

      msg ->
        IO.puts("(serv3) Not handled: #{inspect(msg)}")
        Serv3.loop(acc + 1) 
    end
  end
end
