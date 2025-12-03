defmodule Aoc.Helpers.Grid.PathTest do
  alias Aoc.Helpers.Grid.Path
  alias Aoc.Helpers.Grid.Vector
  alias Aoc.Helpers.Grid
  use ExUnit.Case

  test "find" do
    grid =
      for x <- 0..2,
          y <- 0..2,
          into: Grid.new(),
          do: {Vector.at(x, y), {x, y} != {1, 0}}

    expected_path = [
      Vector.at(0, 1),
      Vector.at(1, 1),
      Vector.at(2, 1),
      Vector.at(2, 0)
    ]

    assert {:ok, 4, ^expected_path} =
             Path.find(grid, Vector.at(0, 0), Vector.at(2, 0))
  end

  test "find_all" do
    grid =
      Grid.parse(
        """
        S..
        ...
        #.E
        """,
        split_on: ""
      )

    all_paths = Path.find_all(grid, Vector.at(0, 0), Vector.at(2, 2), ["."], 5)

    assert Enum.count(all_paths) == 5
  end
end
