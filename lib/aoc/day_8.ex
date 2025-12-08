defmodule Aoc.Day8 do
  alias Aoc.Helpers

  def part_1(input, n \\ 1000) do
    input
    |> parse()
    |> closest_pairs()
    |> Enum.take(n)
    |> Enum.reduce(%{}, &connect_graph/2)
    |> Map.values()
    |> Enum.uniq()
    |> Enum.map(&MapSet.size/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  def part_2(input) do
    junction_boxes = parse(input)
    count = length(junction_boxes)

    junction_boxes
    |> closest_pairs()
    |> Enum.reduce_while(%{}, fn {a, b}, graph ->
      graph = connect_graph({a, b}, graph)

      if graph |> Map.get(a) |> MapSet.size() < count do
        {:cont, graph}
      else
        {:halt, elem(a, 0) * elem(b, 0)}
      end
    end)
  end

  defp parse(input) do
    input
    |> String.split([",", ",", "\n"], trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(3)
    |> Enum.map(&List.to_tuple/1)
  end

  defp closest_pairs(boxes) do
    boxes
    |> Helpers.combinations(2)
    |> Enum.map(fn [a, b] -> {[a, b], distance(a, b)} end)
    |> Enum.sort_by(fn {_, dist} -> dist end)
    |> Stream.map(fn {[a, b], _} -> {a, b} end)
  end

  defp distance({x1, y1, z1}, {x2, y2, z2}) do
    :math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2 + (z2 - z1) ** 2)
  end

  defp connect_graph({a, b}, graph) do
    graph =
      graph
      |> Map.update(a, MapSet.new([b]), &MapSet.put(&1, b))
      |> Map.update(b, MapSet.new([a]), &MapSet.put(&1, a))

    union = MapSet.union(Map.get(graph, a), Map.get(graph, b))
    Enum.reduce(union, graph, fn point, acc -> Map.put(acc, point, union) end)
  end
end
