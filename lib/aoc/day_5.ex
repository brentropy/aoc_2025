defmodule Aoc.Day5 do
  def part_1(input) do
    {id_ranges, available} = parse(input)

    Enum.count(available, fn ingredient ->
      Enum.any?(id_ranges, &(ingredient in &1))
    end)
  end

  def part_2(input) do
    {id_ranges, _} = parse(input)

    id_ranges
    |> merge_overlapping_ranges()
    |> Enum.map(&Range.size/1)
    |> Enum.sum()
  end

  defp parse(input) do
    [id_range_input, available_input] =
      input |> String.trim() |> String.split("\n\n")

    id_ranges =
      id_range_input
      |> String.split("\n")
      |> Enum.map(&parse_range/1)

    available =
      available_input
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)

    {id_ranges, available}
  end

  defp parse_range(range_str) do
    [first, last] = String.split(range_str, "-")
    String.to_integer(first)..String.to_integer(last)//1
  end

  defp merge_overlapping_ranges(ranges) do
    ranges
    |> Enum.sort()
    |> Enum.reduce([], fn
      range, [] ->
        [range]

      range, [head | tail] ->
        if Range.disjoint?(range, head) do
          [range, head | tail]
        else
          [min(range.first, head.first)..max(range.last, head.last)//1 | tail]
        end
    end)
  end
end
