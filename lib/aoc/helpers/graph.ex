defmodule Aoc.Helpers.Graph do
  def distances(graph, from) do
    distances(graph, from, %{from => 0})
  end

  def distances(graph, current, dist_map) do
    next_dist = dist_map[current] + 1

    all_next =
      graph
      |> Map.get(current)
      |> Enum.filter(&(!dist_map[&1] || dist_map[&1] > next_dist))

    next_dist_map =
      all_next
      |> Enum.map(&{&1, next_dist})
      |> Enum.into(dist_map)

    Enum.reduce(all_next, next_dist_map, &distances(graph, &1, &2))
  end
end
