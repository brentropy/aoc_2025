defmodule Aoc.Day4Test do
  use ExUnit.Case

  import Aoc.Day4

  @input Inputs.read("day_4_input.txt")

  @example """
  ..@@.@@@@.
  @@@.@.@.@@
  @@@@@.@.@@
  @.@@@@..@.
  @@.@@@@.@@
  .@@@@@@@.@
  .@.@.@.@@@
  @.@@@.@@@@
  .@@@@@@@@.
  @.@.@@@.@.
  """

  test "part 1 example", do: assert(part_1(@example) == 13)

  @tag :answer
  test "part 1 answer", do: assert(part_1(@input) == 1349)

  test "part 2 example", do: assert(part_2(@example) == 43)

  @tag :answer
  test "part 2 answer", do: assert(part_2(@input) == 8277)
end
