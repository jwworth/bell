require Ecto.Query

defmodule BellWeb.RingHelpers do
  def active_ring_count do
    rings =
      Bell.Repo.all(
        Ecto.Query.from(r in Bell.Ring,
          where: r.inserted_at > datetime_add(^NaiveDateTime.utc_now(), -30, "second")
        )
      )

    length(rings)
  end
end
