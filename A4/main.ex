# Dylan Nicks, Coralee Rogers-Vickers, William Wang

defmodule Main do
  def start do
    serv3_pid = Serv3.start()
    serv2_pid = Serv2.start(serv3_pid)
    serv1_pid = Serv1.start(serv2_pid)
    loop(serv1_pid, serv2_pid, serv3_pid)
  end

  defp loop(serv1_pid, serv2_pid, serv3_pid) do
    IO.puts("Enter a message (or 'all_done' to exit):")
    input = IO.gets("> ") |> String.trim()

    case input do
      "all_done" ->
        send(serv1_pid, :halt)
        IO.puts("Main process exiting.")
        :ok

      "update1" ->
        send(serv1_pid, :update)
        IO.puts("Sent update to serv1.")
        loop(serv1_pid, serv2_pid, serv3_pid)

      "update2" ->
        send(serv2_pid, :update)
        IO.puts("Sent update to serv2.")
        loop(serv1_pid, serv2_pid, serv3_pid)

      "update3" ->
        send(serv3_pid, :update)
        IO.puts("Sent update to serv3.")
        loop(serv1_pid, serv2_pid, serv3_pid)

      _ ->
        case parse_input(input) do
          {:ok, message} ->
            send(serv1_pid, message)
            loop(serv1_pid, serv2_pid, serv3_pid)

          {:error, reason} ->
            IO.puts("Error parsing input: #{inspect(reason)}")
            loop(serv1_pid, serv2_pid, serv3_pid)
        end
    end
  end

  defp parse_input(input) do
    case Code.eval_string(input) do
      {term, _binding} ->
        {:ok, term}

      _ ->
        {:error, :invalid_expression}
    end
  rescue
    e in SyntaxError ->
      {:error, e}
  end
end


