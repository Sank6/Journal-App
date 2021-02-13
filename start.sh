# Navigate to directory
cd Desktop/Journal-App

# Pull changes
git pull

# Recompile changes
mix deps.get --only prod
MIX_ENV=prod mix compile
npm run deploy --prefix ./assets
mix phx.digest

# Migrate if necessary
MIX_ENV=prod mix ecto.migrate

# Run in detached mode
PORT=4001 MIX_ENV=prod elixir --erl "-detached" -S mix phx.server