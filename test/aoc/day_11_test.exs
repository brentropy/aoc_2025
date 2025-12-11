defmodule Aoc.Day11Test do
  use ExUnit.Case

  import Aoc.Day11

  @input Inputs.read("day_11_input.txt")

  @example """
  aaa: you hhh
  you: bbb ccc
  bbb: ddd eee
  ccc: ddd eee fff
  ddd: ggg
  eee: out
  fff: out
  ggg: out
  hhh: ccc fff iii
  iii: out
  """

  test "part 1 example", do: assert(part_1(@example) == 5)

  @tag :answer
  test "part 1 answer", do: assert(part_1(@input) == 764)

  @example2 """
  svr: aaa bbb
  aaa: fft
  fft: ccc
  bbb: tty
  tty: ccc
  ccc: ddd eee
  ddd: hub
  hub: fff
  eee: dac
  dac: fff
  fff: ggg hhh
  ggg: out
  hhh: out
  """

  test "part 2 example", do: assert(part_2(@example2) == 2)

  @tag :answer
  test "part 2 answer", do: assert(part_2(@input) == 462_444_153_119_850)
end
