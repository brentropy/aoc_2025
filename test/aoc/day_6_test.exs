defmodule Aoc.Day6Test do
  use ExUnit.Case

  import Aoc.Day6

  @input Inputs.read("day_6_input.txt")

  @example """
  123 328  51 64
   45 64  387 23
    6 98  215 314
  *   +   *   +
  """

  test "part 1 example", do: assert(part_1(@example) == 4_277_556)

  @tag :answer
  test "part 1 answer", do: assert(part_1(@input) == 4_364_617_236_318)

  test "part 2 example", do: assert(part_2(@example) == 3_263_827)

  @tag :answer
  test "part 2 answer", do: assert(part_2(@input) == 9_077_004_354_241)
end
