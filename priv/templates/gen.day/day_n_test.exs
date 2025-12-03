defmodule Aoc.Day<%= num %>Test do
  use ExUnit.Case

  import Aoc.Day<%= num %>

  @input Inputs.read("day_<%= num %>_input.txt")

  @example """
  example
  """

  test "part 1 example", do: assert(part_1(@example) == nil)

  @tag :answer
  test "part 1 answer", do: assert(part_1(@input) == nil)

  test "part 2 example", do: assert(part_2(@example) == nil)

  @tag :answer
  test "part 2 answer", do: assert(part_2(@input) == nil)
end
