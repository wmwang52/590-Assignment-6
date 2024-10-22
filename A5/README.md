## Team Members:
- Dylan Nicks
- Coralee Rogers-Vickers
- William Wang

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

### Special Notes for Message Handling:

#### 1. **For Serv1**:
- **Binary Operations**: 
  - The server handles arithmetic operations (`:add`, `:sub`, `:mult`, `:div`) for messages that contain two numbers in a tuple. Example:
    ```elixir
    {:add, 3, 7}  # Output: (serv1) add 3, 7 = 10
    ```
  - Make sure to include the colon (`:`) before the operation name to define it as an atom.

- **Unary Operations**:
  - For operations like negation (`:neg`) and square root (`:sqrt`), the tuple contains a single number. Example:
    ```elixir
    {:neg, 4}  # Output: (serv1) neg 4 = -4
    ```

#### 2. **For Serv3**:
- **Error Handling**:
  - `Serv3` intercepts error messages of the form `{:error, message}` and prints the error. Example:
    ```elixir
    {:error, "Something went wrong"}  # Output: (serv3) Error: "Something went wrong"
    ```

- **Unprocessed Message Counter**:
  - For any unrecognized message, `Serv3` increments a counter and prints the message:
    ```elixir
    :unknown_message  # Output: (serv3) Not handled: :unknown_message
    ```