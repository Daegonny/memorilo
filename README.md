# Memorilo

A simple elixir OTP project for exercise DynamicSupervisor and Cron concepts.
The app let you schedule messages and keeps them in GenServer worker states until the time they should be delivered. Them they are printed and the worker dies.

## How to run

1. install dependencies:
```elixir
mix deps.get
```

2. start application
```elixir
iex -S mix
```

3. monitor the application
```elixir
:observer.start()
```

4. send a dummy message
```elixir
Memorilo.send_dummy_message
```