defmodule Aoc.HelpersTest do
  use ExUnit.Case

  import Aoc.Helpers

  test "permutations with repeats" do
    result = permutations([1, 2, 3], 3, repeats: true)

    expected = [
      [1, 1, 2],
      [1, 1, 3],
      [1, 2, 1],
      [1, 2, 3],
      [1, 3, 1],
      [1, 3, 2],
      [2, 1, 2],
      [2, 1, 3],
      [2, 2, 1],
      [2, 2, 3],
      [2, 3, 1],
      [2, 3, 2],
      [3, 1, 2],
      [3, 1, 3],
      [3, 2, 1],
      [3, 2, 3],
      [3, 3, 1],
      [3, 3, 2]
    ]

    assert result == expected
  end

  test "permutations without repeats" do
    result = permutations([1, 2, 3], 3, repeats: false)

    expected = [
      [1, 2, 3],
      [1, 3, 2],
      [2, 1, 3],
      [2, 3, 1],
      [3, 1, 2],
      [3, 2, 1]
    ]

    assert result == expected
  end

  test "combinations" do
    result = combinations([1, 2, 3], 2)
    expected = [[1, 2], [1, 3], [2, 3]]
    assert result == expected
  end
end
