# Memorilo

A simple elixir phoenix live view OTP project for exercise DynamicSupervisor and Cron concepts.
The app let you schedule messages and keeps them in GenServer worker states until the time they should be delivered. Then they are printed and the worker dies.

## How to run

1. Install dependencies with `mix deps.get`

2. Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
