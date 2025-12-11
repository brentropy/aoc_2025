defmodule Aoc.Day11 do
  use Memoize

  def part_1(input) do
    input
    |> parse()
    |> count_paths("you", "out")
  end

  def part_2(input) do
    graph = parse(input)
    svr_to_fft = count_paths(graph, "svr", "fft")
    svr_to_dac = count_paths(graph, "svr", "dac")
    dac_to_fft = count_paths(graph, "dac", "fft")
    fft_to_dac = count_paths(graph, "fft", "dac")
    dac_to_out = count_paths(graph, "dac", "out")
    fft_to_out = count_paths(graph, "fft", "out")

    svr_to_fft * fft_to_dac * dac_to_out + svr_to_dac * dac_to_fft * fft_to_out
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      [device | connections] = String.split(line, ~r":?\s")
      {device, connections}
    end)
    |> Enum.into(%{})
  end

  defmemop count_paths(_graph, a, b) when a == b, do: 1

  defmemop count_paths(graph, a, b) do
    case Map.get(graph, a) do
      nil -> 0
      devices -> devices |> Enum.map(&count_paths(graph, &1, b)) |> Enum.sum()
    end
  end
end
