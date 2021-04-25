defmodule Snipzy.Repo do
  use Ecto.Repo,
    otp_app: :snipzy,
    adapter: Ecto.Adapters.Postgres
end
