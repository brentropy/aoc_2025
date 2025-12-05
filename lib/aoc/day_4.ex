defmodule Aoc.Day4 do
  alias Aoc.Helpers.Grid

  def part_1(input) do
    grid = parse(input)
    Enum.count(grid, &accessible?(grid, &1))
  end

  def part_2(input) do
    grid_before = input |> Grid.parse(split_on: "")
    grid_after = simulate(grid_before)
    roll_count(grid_before) - roll_count(grid_after)
  end

  defp parse(input), do: Grid.parse(input, split_on: "")

  defp accessible?(grid, {pos, "@"}) do
    adjecent =
      grid
      |> Grid.neighbors(pos, diagonal: true)
      |> Enum.count(fn {_, cell} -> cell == "@" end)

    adjecent < 4
  end

  defp accessible?(_, _), do: false

  defp roll_count(grid) do
    Enum.count(grid, fn {_, v} -> v == "@" end)
  end

  defp simulate(grid) do
    next =
      Enum.reduce(grid, grid, fn {vec, val}, acc ->
        if val != "." do
          adjecent =
            grid
            |> Grid.neighbors(vec, diagonal: true)
            |> Enum.count(fn {_, v} -> v == "@" end)

          if adjecent < 4, do: Grid.put(acc, vec, "."), else: acc
        else
          acc
        end
      end)

    if next != grid, do: simulate(next), else: grid
  end
end
