defmodule Aoc.Day8Test do
  use ExUnit.Case

  import Aoc.Day8

  @input Inputs.read("day_8_input.txt")

  @example """
  162,817,812
  57,618,57
  906,360,560
  592,479,940
  352,342,300
  466,668,158
  542,29,236
  431,825,988
  739,650,466
  52,470,668
  216,146,977
  819,987,18
  117,168,530
  805,96,715
  346,949,466
  970,615,88
  941,993,340
  862,61,35
  984,92,344
  425,690,689
  """

  test "part 1 example", do: assert(part_1(@example, 10) == 40)

  @tag :answer
  test "part 1 answer", do: assert(part_1(@input) == 115_885)

  test "part 2 example", do: assert(part_2(@example) == 25272)

  @tag :answer
  test "part 2 answer", do: assert(part_2(@input) == 274_150_525)
end
