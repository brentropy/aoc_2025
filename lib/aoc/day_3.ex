defmodule Aoc.Day3 do
  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&Integer.digits/1)
  end

  def part_1(input) do
    input
    |> parse()
    |> Enum.map(&max_joltage(&1, 2))
    |> Enum.sum()
  end

  def part_2(input) do
    input
    |> parse()
    |> Enum.map(&max_joltage(&1, 12))
    |> Enum.sum()
  end

  defp max_joltage(bank, cell_count) do
    bank_size = length(bank)
    cells_idx = Enum.with_index(bank)

    1..cell_count
    |> Enum.reduce({0, []}, fn i, {start_idx, selected} ->
      {cell, idx} =
        Enum.reduce(cells_idx, {0, 0}, fn {cell, idx}, {cur_max, next_idx} ->
          if idx >= start_idx and idx < bank_size - cell_count + i and
               cell > cur_max do
            {cell, idx}
          else
            {cur_max, next_idx}
          end
        end)

      {idx + 1, [cell | selected]}
    end)
    |> elem(1)
    |> Enum.reverse()
    |> Integer.undigits()
  end
end
