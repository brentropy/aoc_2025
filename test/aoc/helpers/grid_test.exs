defmodule Aoc.Helpers.GridTest do
  alias Aoc.Helpers.Grid.Vector
  alias Aoc.Helpers.Grid
  use ExUnit.Case

  test "get" do
    vector = Vector.at(1, 2, 3)
    grid = Enum.into([{vector, 47}], Grid.new())
    assert Grid.get(grid, vector) == 47
  end

  test "start" do
    result = Grid.get(Grid.start(47), Vector.at(0, 0, 0))
    assert result == 47
  end
end
