defmodule Aoc.Day7 do
  alias Aoc.Helpers.Grid
  alias Aoc.Helpers.Grid.Vector

  def part_1(input) do
    {grid, start} = parse(input)
    total_splits(grid, MapSet.new([start.x]), 1, 0)
  end

  def part_2(input) do
    {grid, start} = parse(input)
    total_timelines(grid, %{start.x => 1}, 1)
  end

  defp parse(input) do
    grid = Grid.parse(input, split_on: "")
    {start, _} = Enum.find(grid, fn {_, val} -> val == "S" end)
    {grid, start}
  end

  defp total_splits(grid, _, y, count) when y > grid.max_y, do: count

  defp total_splits(grid, beams, y, split_count) do
    {next_beams, next_split_count} =
      beams
      |> Enum.reduce(
        {MapSet.new(), split_count},
        fn beam, {beams_acc, split_count_acc} ->
          if Grid.get(grid, Vector.at(beam, y)) == "^" do
            next_beams_acc =
              beams_acc
              |> MapSet.put(beam - 1)
              |> MapSet.put(beam + 1)

            {next_beams_acc, split_count_acc + 1}
          else
            {MapSet.put(beams_acc, beam), split_count_acc}
          end
        end
      )

    total_splits(grid, next_beams, y + 1, next_split_count)
  end

  defp total_timelines(grid, beams, y) when y > grid.max_y do
    beams |> Map.values() |> Enum.sum()
  end

  defp total_timelines(grid, beams, y) do
    next_beams =
      Enum.reduce(beams, %{}, fn {beam, beam_count}, beams_acc ->
        if Grid.get(grid, Vector.at(beam, y)) == "^" do
          beams_acc
          |> Map.update(beam - 1, beam_count, &(&1 + beam_count))
          |> Map.update(beam + 1, beam_count, &(&1 + beam_count))
        else
          beams_acc |> Map.update(beam, beam_count, &(&1 + beam_count))
        end
      end)

    total_timelines(grid, next_beams, y + 1)
  end
end
