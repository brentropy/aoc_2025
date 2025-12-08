defmodule Aoc.Day6 do
  def part_1(input) do
    [operators | rows] =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.split(&1, ~r"\s+", trim: true))
      |> Enum.reverse()

    rows
    |> Enum.map(fn r -> Enum.map(r, &String.to_integer/1) end)
    |> Enum.reduce(fn row, acc ->
      Enum.zip([operators, acc, row])
      |> Enum.map(fn
        {"*", a, n} -> a * n
        {"+", a, n} -> a + n
      end)
    end)
    |> Enum.sum()
  end

  def part_2(input) do
    lines = input |> String.trim() |> String.split("\n")
    max_width = lines |> Enum.map(&String.length/1) |> Enum.max()

    [operators | rows] =
      lines
      |> Enum.map(fn line ->
        line
        |> String.pad_trailing(max_width)
        |> String.codepoints()
      end)
      |> Enum.reverse()

    cols =
      rows
      |> Enum.zip()
      |> Enum.map(fn row ->
        vertical_num =
          row
          |> Tuple.to_list()
          |> Enum.join()
          |> String.trim()
          |> String.reverse()

        if vertical_num == "" do
          nil
        else
          String.to_integer(vertical_num)
        end
      end)
      |> Enum.reduce([[]], fn
        nil, tail -> [[] | tail]
        n, [head | tail] -> [[n | head] | tail]
      end)
      |> Enum.reverse()

    operators
    |> Enum.filter(&(&1 != " "))
    |> Enum.zip(cols)
    |> Enum.map(fn
      {"*", col} -> Enum.product(col)
      {"+", col} -> Enum.sum(col)
    end)
    |> Enum.sum()
  end
end
