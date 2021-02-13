Journal App
===========

A self-hosted journal web app using the Phoenix framework and a PostgreSQL database. 

![](https://i.postimg.cc/RCLxHw51/image.png)
![](https://i.postimg.cc/6pLZsHD2/image.png)
![](https://i.postimg.cc/kMBpvHHy/image.png)


# Setup
You need [nodejs](https://nodejs.org/download/), [elixir](https://elixir-lang.org/install.html), the [Phoenix framework](https://hexdocs.pm/phoenix/installation.html) and a Postgres server.
 - Clone the repo
 - Edit `config/config.exs` with an [unsplash access key](https://unsplash.com/oauth/applications) and database details.
 - Install the dependencies with `mix deps.get`.
 - Create and migrate your database with `mix ecto.setup`.
 - Install Node.js dependencies with `npm install` inside the `assets` directory.
 - Start Phoenix endpoint with `mix phx.server`.


# Production 

Full documentation at the [phoenix guide](https://hexdocs.pm/phoenix/deployment.html).

 - Generate a secret key base with `mix phx.gen.secret` and export it with `export SECRET_KEY_BASE=REALLY_LONG_SECRET`
 - Export the database url with `export DATABASE_URL=ecto://USER:PASS@HOST/database`
```sh
# Compile
mix deps.get --only prod
MIX_ENV=prod mix compile
npm run deploy --prefix ./assets
mix phx.digest

# Migrate if necessary
MIX_ENV=prod mix ecto.migrate

# Run in detached mode
PORT=4001 MIX_ENV=prod elixir --erl "-detached" -S mix phx.server```

