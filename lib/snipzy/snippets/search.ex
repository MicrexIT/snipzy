defmodule Snipzy.Snippets.Search do
  import Ecto.Query
  alias Snipzy.Snippets.Snippet

  # https://www.postgresql.org/docs/current/static/textsearch-controls.html#TEXTSEARCH-PARSING-QUERIES
  defmacro plainto_tsquery(query) do
    quote do
      fragment("plainto_tsquery('english', ?)", unquote(query))
    end
  end

  # https://www.postgresql.org/docs/current/static/textsearch-controls.html#TEXTSEARCH-RANKING
  defmacro ts_rank_cd(tsv, query) do
    quote do
      fragment("ts_rank_cd(?, ?)", unquote(tsv), unquote(query))
    end
  end

  def get_user_query(sentence, user) do
    Snippet
    |> where([snippet], snippet.user_id == ^user.id)
    |> where([snippet], fragment("? @@ ?", snippet.tsv, plainto_tsquery(^sentence)))
    |> order_by([snippet], desc: ts_rank_cd(snippet.tsv, plainto_tsquery(^sentence)))
  end
end
