defmodule Aoc.Day1Test do
  use ExUnit.Case

  import Aoc.Day1

  @input Inputs.read("day_1_input.txt")

  @example """
  L68
  L30
  R48
  L5
  R60
  L55
  L1
  L99
  R14
  L82
  """

  test "part 1 example", do: assert(part_1(@example) == 3)

  @tag :answer
  test "part 1 answer", do: assert(part_1(@input) == 1089)

  test "part 2 example", do: assert(part_2(@example) == 6)

  test "part 2 multiple rotations", do: assert(part_2("R1000") == 10)

  @tag :answer
  test "part 2 answer", do: assert(part_2(@input) == 6530)
end
