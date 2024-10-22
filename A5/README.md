
1. **Navigate to the `a5` directory**:
   
   Open a terminal and change to the `a5` directory:

   ```bash
   cd a5
   ```

2. **Start an `IEx` session**:
   
   Once inside the `a5` directory, start the Elixir interactive shell (`iex`):

   ```bash
   iex
   ```

3. **Compile and load the modules**:

   In the `IEx` shell, compile and load each of the `.ex` files:

   ```elixir
   c("serv1.ex")
   c("serv2.ex")
   c("serv3.ex")
   c("main.ex")
   ```

4. **Start the program**:

   After compiling the files, start the message-passing chain by calling:

   ```elixir
   Main.start()
   ```

5. **Send messages and updates**:
   You can now interact with the servers by sending messages and update instructions.
