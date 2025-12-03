defmodule Aoc.Day3Test do
  use ExUnit.Case

  import Aoc.Day3

  @input Inputs.read("day_3_input.txt")

  @example """
  987654321111111
  811111111111119
  234234234234278
  818181911112111
  """

  test "part 1 example", do: assert(part_1(@example) == 357)

  @tag :answer
  test "part 1 answer", do: assert(part_1(@input) == 17113)

  test "part 2 example", do: assert(part_2(@example) == 3_121_910_778_619)

  @tag :answer
  test "part 2 answer", do: assert(part_2(@input) == 169_709_990_062_889)
end
