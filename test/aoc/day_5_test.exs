defmodule Aoc.Day5Test do
  use ExUnit.Case

  import Aoc.Day5

  @input Inputs.read("day_5_input.txt")

  @example """
  3-5
  10-14
  16-20
  12-18

  1
  5
  8
  11
  17
  32
  """

  test "part 1 example", do: assert(part_1(@example) == 3)

  @tag :answer
  test "part 1 answer", do: assert(part_1(@input) == 770)

  test "part 2 example", do: assert(part_2(@example) == 14)

  @tag :answer
  test "part 2 answer", do: assert(part_2(@input) == 357_674_099_117_260)
end
