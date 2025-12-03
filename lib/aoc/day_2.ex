defmodule Aoc.Day2 do
  alias Aoc.Helpers

  defp parse(input) do
    input
    |> String.trim()
    |> String.split(["-", ","])
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Stream.flat_map(fn [first, last] -> first..last end)
  end

  def part_1(input) do
    input
    |> parse()
    |> Stream.filter(&even_digits?/1)
    |> Stream.filter(&repeats?(Integer.digits(&1), 2))
    |> Enum.sum()
  end

  def part_2(input) do
    input
    |> parse()
    |> Stream.filter(&repeats?(Integer.digits(&1)))
    |> Enum.sum()
  end

  defp even_digits?(n), do: n |> :math.log10() |> trunc() |> rem(2) == 1

  defp same?([_]), do: false
  defp same?(chunks), do: chunks |> Enum.dedup() |> Enum.count() == 1

  defp repeats?(digits) do
    digits
    |> Enum.count()
    |> Helpers.divisors()
    |> Enum.any?(&repeats?(digits, &1))
  end

  defp repeats?(digits, divisor) do
    digits
    |> Enum.chunk_every(div(Enum.count(digits), divisor))
    |> same?()
  end
end
