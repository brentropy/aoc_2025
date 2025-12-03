defmodule Aoc.Day2Test do
  use ExUnit.Case

  import Aoc.Day2

  @input Inputs.read("day_2_input.txt")

  @example """
  11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
  """

  test "part 1 example", do: assert(part_1(@example) == 1_227_775_554)

  @tag :answer
  test "part 1 answer", do: assert(part_1(@input) == 38_158_151_648)

  test "part 2 example", do: assert(part_2(@example) == 4_174_379_265)

  @tag :answer
  test "part 2 answer", do: assert(part_2(@input) == 45_283_684_555)
end
