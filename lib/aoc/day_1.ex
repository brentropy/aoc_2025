defmodule Aoc.Day1 do
  alias Aoc.Helpers

  defp parse(input) do
    input |> String.trim() |> String.split("\n") |> Enum.map(&parse_dir/1)
  end

  defp parse_dir("L" <> n), do: -String.to_integer(n)
  defp parse_dir("R" <> n), do: String.to_integer(n)

  defp turn(change, {current, zero_count}) do
    next = Integer.mod(current + change, 100)
    {next, if(next == 0, do: zero_count + 1, else: zero_count)}
  end

  def part_1(input) do
    input
    |> parse()
    |> Enum.reduce({50, 0}, &turn/2)
    |> elem(1)
  end

  def part_2(input) do
    input
    |> parse()
    |> Stream.flat_map(&Stream.duplicate(Helpers.sign(&1), abs(&1)))
    |> Enum.reduce({50, 0}, &turn/2)
    |> elem(1)
  end
end
