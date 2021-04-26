# Snipzy

Snippets made easy peasy

## Stack
Elixir, Phoenix, Tailwindcss, Alpinejs, Liveview
## Instructions
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Current Features
  
  - Authentication generated with [phx_gen_auth](https://github.com/aaronrenner/phx_gen_auth)
  - CRUD operations on snippet (scoped to current user)
  - Search snippet by title (accounts for caps letter and finds a word a a title)
